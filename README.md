# azatrg_infra
azatrg Infra repository

## Знакомство с облачной инфраструктурой. Yandex.cloud

### Самостоятельное задание

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

## VPN-сервер для серверов Yandex.cloud

bastion_IP = 51.250.10.192
someinternalhost_IP = 10.128.0.17

## Деплой тестового приложения

testapp_IP =
testapp_port =
