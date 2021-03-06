#!/bin/bash
cat <<EOANSIBLESCRIPT
{
    "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": "62.84.126.108"
            },
            "dbserver": {
                "ansible_host": "62.84.126.132"
            }
        }
    },
    "all": {
        "children": [
            "app",
            "db",
            "ungrouped"
        ]
    },
    "app": {
        "hosts": [
            "appserver"
        ]
    },
    "db": {
        "hosts": [
            "dbserver"
        ]
    }
}
EOANSIBLESCRIPT
