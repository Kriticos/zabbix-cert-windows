# 🛠️ Tutorial - Monitoramento de Certificados no Windows com Zabbix Agent 2

## 📁 Estrutura de arquivos

Abaixo um exemplo da estrutura de pasta onde os certificados devem ficar, copie os scripts a seguir no host monitorado (Windows com Zabbix Agent 2):

```makefile
C:\Scripts\Zabbix\Certificados\
│
├── discover-certs.ps1
└── check_cert_expiry.ps1
```

## 🔧 2. Configuração do zabbix_agent2.conf

Edite o arquivo zabbix_agent2.conf:

Localize a linha "Userparameter=" e na linha de baixo adicione o conteudo abaixo.

```powershell
# Monitoramento de certificados
UserParameter=cert.discovery,powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\Zabbix\Certificados\discovery-certs.ps1"
UserParameter=cert.expira[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\Zabbix\Certificados\check_cert_expiry.ps1" -thumb "$1"
```

## 🔧 3. Configuração do Host

Para manter o ambiente organizado, crie um host com o nome “Certificados - Windows” ou outro de sua preferencia.
Em seguida, associe o template “BSKP - Certificados - Windows” e defina o IP do servidor onde os certificados estão instalados.

💡 Essa configuração permite centralizar o monitoramento dos certificados de máquinas específicas com maior clareza e padronização.

## OBSERVAÇÃO

Aconselhavel remover o certificado vencido do servidor, caso contrario ele ficara alertando no painel do zabbix até zerar a data de expiração.
