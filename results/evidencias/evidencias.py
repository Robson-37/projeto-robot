import os
# Importa o módulo responsável por operações com arquivos e diretórios.

from PIL import ImageGrab
# Importa a classe ImageGrab da biblioteca Pillow,
# utilizada para capturar a tela do computador.

def tirar_screenshot_desktop(caminho_arquivo):
    """
    Captura uma imagem de toda a área de trabalho
    e salva no caminho informado.
    """

    # Cria a pasta de evidências caso ela não exista.
    os.makedirs(os.path.dirname(caminho_arquivo), exist_ok=True)

    # Captura uma imagem da tela inteira.
    # Inclui área de trabalho, barra de tarefas,
    # relógio e demais elementos visíveis do sistema.
    screenshot = ImageGrab.grab()

    # Salva a imagem capturada no arquivo especificado.
    screenshot.save(caminho_arquivo)