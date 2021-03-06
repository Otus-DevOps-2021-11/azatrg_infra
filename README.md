# azatrg_infra
azatrg Infra repository

# Оглавление

- [Yandex cloud ](#yandex.cloud)
- [Деплой тестового приложения](#Деплой-Тестового-приложения)
- [Использование Terraform](#-Использование-Terraform)
- [Ansible](#-ansible)


[![Run Packer templates validation](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/packer-validate.yml/badge.svg)](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/packer-validate.yml)
[![Run Terraform validation & tflint](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/terraform-tflint.yml/badge.svg)](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/terraform-tflint.yml)
[![Run Ansible Lint](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/ansible-lint.yml)
[![Run tests for OTUS homework](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/run-tests.yml/badge.svg)](https://github.com/Otus-DevOps-2021-11/azatrg_infra/actions/workflows/run-tests.yml)

# Yandex.cloud
#### Самостоятельное задание

Для подключения к хосту без внешнего ip-адреса (someinternalhost) по ssh в одну команду, надо использовать ключ -J. Источник man ssh. Вот сама команда:

```
ssh -i ~/.ssh/appuser -J appuser@51.250.4.155 appuser@10.128.0.17
```

#### Дополнительное задание

Для подключения к someinternalhost с помощью команды ***ssh someinternalhost***, надо внести следующие изменения в файл ~/.ssh/config на локальной машине. Сделать это можно одной командой:

```
touch ~/.ssh/config && cat <<\EOF >>~/.ssh/config
### The Bastion Host
> Host bastion
>   HostName 51.250.10.192
>   User appuser
>
> ### The Remote Host
> Host someinternalhost
>   HostName 10.128.0.17
>   ProxyJump bastion
>   User appuser
> EOF
```
Затем подключаемся сразу к someinternalhost
```
ssh someinternalhost
```

#### VPN-сервер для серверов Yandex.cloud

bastion_IP = 51.250.10.192
someinternalhost_IP = 10.128.0.17


## Деплой тестового приложения

#### Адрес приложения

testapp_IP = 51.250.10.38
testapp_port = 9292

#### Дополнительное задание

Startup script находиться тут - https://gist.githubusercontent.com/azatrg/772a709cc72731bf436e2585d78a0207/raw/2432fb763f8e8e51276e83f2ff885d360414ea3a/deploy_ruby_mongo_app.sh
вызов происходит из файла metadata.yaml, который добавлен в текущий репозиторий. Для автоматического деплоя интанса со startup script используется команда:
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --core-fraction 50 \
  --memory=2 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=metadata.yaml
```

При этом обращаю внимание, что сначала создается инстанс, потом выполняется скрипт. Поэтому приложение будет доступно примерно через 2 минуты после старта инстанса. Лог выполнения скрипта можно посмотреть командой:
```
sudo less /var/log/cloud-init-output.log
```

## Использование Terraform


На данный момент структура terraform проекта следующая:

├── files         # папка с файлами для провижена
│   ├── deploy.sh
│   └── puma.service
├── lb.tf         # Описание load balancer
├── main.tf       # Подключение к провайдеру и описание инстансов
├── outputs.tf    # Выходные переменные с адресами инстансов и балансировщика
├── terraform.tfvars.example  # файл с фейковыми переменными для авто-тестов
├── variables.tf  # Описание входных переменных


# Ansible

### Про запуск плейбука clone.yml.
В первый раз папка, которая должна была появиться в результате команды уже была, поэтому ансибл ничего не сделал: changed=0. После удаления папки и повторного запуска плейбука папка была скопирована заново и ансибл вевел статус changed=1.

### * JSON-inventory.

Как я понял сам файл в формате json в качестве inventory ansible не принимает, ему нужен скрипт, который будет выводить json с форматированием понятным ансиблу. Сделал пока его статическим, Если будет время то возможно напишу динамический инвентори.

### Dynamic inventory для yandexcloud

1. Установить модуль yandexcloud==0.10.1. Для удобства добавил в requirements.txt
2. Создал папку ./plugins/inventory , скопировал туда плагин.
3. Для просмотра документации используется команда:
```
ansible-doc -M ./plugins/ -t inventory yc_compute
```
4. Заполнил файл yc.yml , в нем настройки плагина dymanic inventory.
5. Внес правки в ansible.cfg - добавил путь к плагину и включил его.

### Ansible роли.

1. Плейбуки app и db перенесены в роли.
2. Использована community роль для nginx.
3. Разделены окружения stage и prod.
4. Использован Ansible Vault для хранения секретов.
5. Инвентори в окружения динамический (yc_compute)
6. Добавлены github actions для проверки файлов. packer, terraform и ansible.
