//Вызов модуля security-events-to-storage-exporter
module "security-events-to-storage-exporter" {
    source = "../security-events-to-storage-exporter/" # путь до модуля

    folder_id = "b1g30dckl1ctvpjqdudf" // folder-id кластера k8s yc managed-kubernetes cluster get --id <ID кластера> --format=json | jq  .folder_id

    cluster_name = "k8s-exporter1" //имя кластера

    log_bucket_service_account_id = "ajemr9kufi6si6p778n0" //id sa (должен обладать ролями: ymq.admin, write to bucket)
    
    log_bucket_name = "k8s-exporter1" //можно подставить из конфига развертывания
    #function_service_account_id = "чч" // опциоанальный id сервисного аккаунта который вызывает функции - если не выставлен то функция вызывается от имени log_bucket_service_account_id
}


//Вызов модуля security-events-to-siem-importer
module "security-events-to-siem-importer" {
    source = "../security-events-to-siem-importer/" # путь до модуля

    folder_id = module.security-events-to-storage-exporter.folder_id 
    
    service_account_id = module.security-events-to-storage-exporter.service_account_id
    
    auditlog_enabled = true //отправлять k8s auditlog в elk
    
    falco_enabled = true // отправлять алерты falco в elk 

    log_bucket_name = module.security-events-to-storage-exporter.log_bucket_name

    elastic_server = "https://c-c9q5s2n6ihabttfdt9r1.rw.mdb.yandexcloud.net" // url ELK "https://c-xxx.rw.mdb.yandexcloud.net" (можно подставить из модуля module.yc-managed-elk.elk_fqdn)

    coi_subnet_id = "e9bifj73ht64lu8g19su" // subnet id в которой будет развернута ВМ с контейнером (обязательно включить NAT)

    elastic_pw = "!QAZ2wsx" // пароль учетной записи ELK (можно подставить из модуля module.yc-managed-elk.elk-pass)
    
    elastic_user = "admin" // имя учетной записи ELK
}




