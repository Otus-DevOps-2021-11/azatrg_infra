# azatrg_infra
azatrg Infra repository

## 5. Знакомство с облачной инфраструктурой. Yandex.cloud

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


## 6. Деплой тестового приложения

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

## 8. Практика IaC. Использование Terraform.

Сделал пока все кроме последнего задания с **, где надо добавить второй инстанс используя count.

На данный момент структура terraform проекта следующая:

├── files         # папка с файлами для провижена
│   ├── deploy.sh
│   └── puma.service
├── lb.tf         # Описание load balancer
├── main.tf       # Подключение к провайдеру и описание инстансов
├── outputs.tf    # Выходные переменные с адресами инстансов и балансировщика
├── terraform.tfvars.example  # файл с фейковыми переменными для авто-тестов
├── variables.tf  # Описание входных переменных
