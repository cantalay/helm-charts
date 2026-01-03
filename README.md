# Helm Charts Repository

Bu repository Spring Boot ve Expo Web uygulamaları için global Helm chart'larını içerir.

## Chart Yayınlama Adımları

### 1. Chart Versiyonunu Güncelle

Chart şablonlarında değişiklik yaptıysan (templates/, values.yaml), Chart.yaml dosyasındaki `version` alanını artır:

```yaml
# charts/expo-app/Chart.yaml veya charts/spring-boot-app/Chart.yaml
version: 0.1.3  # Artır: 0.1.2 -> 0.1.3
```

**Sadece image tag değiştiyse:** Chart version artırma, sadece `appVersion` veya `values.yaml` içindeki image tag'i güncelle.

### 2. Komutları Çalıştır

```bash
# Chart'ı kontrol et
helm lint charts/expo-app
# veya
helm lint charts/spring-boot-app

# Chart'ı paketle
helm package charts/expo-app
# veya
helm package charts/spring-boot-app

# Repository index'ini güncelle
helm repo index . --merge index.yaml

# Değişiklikleri commit ve push et
git add .
git commit -m "chore: update expo-app chart to 0.1.3"
git push
```

#### Helm Chart Commit Edildikten Sonra Kontrol
```bash
helm repo add cantalay https://cantalay.github.io/helm-charts
helm repo update
helm search repo cantalay/spring-boot-app
# veya
helm search repo cantalay/expo-web-app
#veya
helm search repo cantalay
```
### 3. Terraform'da Versiyon Güncelle

Chart version artırdıysan, Terraform'daki `helm_release` resource'unda `version` alanını güncelle:
```hcl
resource "helm_release" "auth_gateway" {
  chart      = "spring-boot-app"
  repository = "https://cantalay.github.io/helm-charts"

  version = "0.1.1"   # <-- eski versiyon burada güncellenir
}
# Expo için:
#chart   = "expo-web-app"
#version = "0.1.1"
```
**Sadece image tag değiştiyse:** Terrafor
m'da chart version değiştirme, sadece image tag'i güncelle.

## Versiyon Artırma Kuralları

- **Chart version artır:** templates/ klasöründeki dosyalarda değişiklik, values.yaml'da yeni/degisen parametre, Chart.yaml'da metadata değişikliği
- **Sadece image tag güncelle:** Uygulama kodu değişti, sadece container image tag'i güncelleniyor

## Sıralı İş Akışı

1. Chart değişikliklerini yap
2. Chart.yaml'da `version` artır (gerekirse)
3. `helm lint` çalıştır
4. `helm package` çalıştır
5. `helm repo index .` çalıştır
6. `git add`, `git commit`, `git push` yap
7. Terraform'da `helm_release.version` güncelle (chart version artırdıysan)

