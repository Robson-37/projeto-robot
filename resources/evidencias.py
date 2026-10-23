import os
import ctypes
from robot.api import logger
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

# Garante que o processo seja DPI-aware no Windows para capturar a tela inteira
# em resolução nativa (evita cortes na barra de tarefas em telas com escala de 125% ou 150%)
try:
    ctypes.windll.shcore.SetProcessDpiAwareness(2)
except Exception:
    try:
        ctypes.windll.user32.SetProcessDPIAware()
    except Exception:
        pass


class evidencias:
    """Biblioteca personalizada para captura de evidências da tela cheia no Robot Framework e Allure."""
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword('Obter Opcoes Do Chrome')
    def obter_opcoes_do_chrome(self):
        """Retorna as opções do Chrome configuradas para automação limpa:
        desativa popups de vazamento de senha ('Mude sua senha'), gerenciador de credenciais e notificações."""
        from selenium.webdriver.chrome.options import Options
        options = Options()
        options.add_argument('--incognito')
        options.add_argument('--disable-save-password-bubble')
        options.add_argument('--disable-notifications')
        options.add_argument('--disable-popup-blocking')
        options.add_argument('--disable-features=PasswordLeakDetection,AutofillServerCommunication,PasswordManager')
        prefs = {
            "credentials_enable_service": False,
            "profile.password_manager_enabled": False,
            "profile.password_manager_leak_detection": False,
            "safebrowsing.enabled": False
        }
        options.add_experimental_option("prefs", prefs)
        return options

    @keyword('Tirar Screenshot Desktop')
    def tirar_screenshot_desktop(self, caminho):
        """Captura a tela inteira do computador (incluindo a barra de tarefas com data e hora)."""
        # Sanitiza caracteres proibidos no Windows (como dois-pontos em nomes de arquivos)
        diretorio, arquivo = os.path.split(caminho)
        arquivo_sanitizado = arquivo.replace(': ', ' - ').replace(':', '-')

        # Considera o diretório de saída do Robot Framework (${OUTPUT DIR})
        try:
            output_dir = BuiltIn().get_variable_value('${OUTPUT DIR}')
        except Exception:
            output_dir = None

        if not os.path.isabs(diretorio) and output_dir:
            diretorio_completo = os.path.join(output_dir, diretorio)
        else:
            diretorio_completo = diretorio if diretorio else (output_dir if output_dir else '.')

        if not os.path.exists(diretorio_completo):
            os.makedirs(diretorio_completo, exist_ok=True)

        caminho_final = os.path.join(diretorio_completo, arquivo_sanitizado)

        sucesso = False

        # 1. Tentativa principal: Pillow (ImageGrab da tela inteira)
        try:
            from PIL import ImageGrab
            screenshot = ImageGrab.grab(all_screens=True)
            screenshot.save(caminho_final)
            sucesso = True
        except Exception as e_pil:
            logger.info(f"Pillow não disponível ou falhou: {e_pil}. Tentando fallback...")

        # 2. Fallback: PowerShell com System.Drawing (nativo do Windows, sem necessidade de pip)
        if not sucesso:
            try:
                import subprocess
                ps_script = (
                    f"Add-Type -AssemblyName System.Windows.Forms,System.Drawing; "
                    f"$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; "
                    f"$bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height; "
                    f"$graphics = [System.Drawing.Graphics]::FromImage($bitmap); "
                    f"$graphics.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size); "
                    f"$bitmap.Save('{caminho_final}', [System.Drawing.Imaging.ImageFormat]::Png); "
                    f"$graphics.Dispose(); $bitmap.Dispose()"
                )
                subprocess.run(["powershell", "-NoProfile", "-Command", ps_script], check=True, capture_output=True)
                sucesso = True
            except Exception as e_ps:
                logger.warn(f"Fallback via PowerShell falhou ({e_ps}). Usando captura de página do Selenium...")
                # 3. Fallback: SeleniumLibrary
                selenium_lib = BuiltIn().get_library_instance('SeleniumLibrary')
                selenium_lib.capture_page_screenshot(caminho_final)
                sucesso = True

        # Anexa a imagem como visualização HTML no relatório log.html do Robot Framework
        if output_dir:
            caminho_relativo = os.path.relpath(caminho_final, output_dir).replace('\\', '/')
        else:
            caminho_relativo = caminho_final.replace('\\', '/')

        logger.info(
            f'</td></tr><tr><td colspan="3">'
            f'<a href="{caminho_relativo}"><img src="{caminho_relativo}" width="800px"></a>',
            html=True
        )

        # Anexa a evidência diretamente ao relatório do Allure (quando executado com Allure listener)
        try:
            import allure
            allure.attach.file(
                caminho_final,
                name=f"Evidência - {arquivo_sanitizado}",
                attachment_type=allure.attachment_type.PNG
            )
        except Exception as e_allure:
            logger.debug(f"Allure attach ignorado: {e_allure}")

        return caminho_final
