global:
  cluster:
    provider: "{{ cloud_provider }}"
reclaimPolicy: Delete
volumeBindingMode: Immediate
{% if cloud_provider == "aws" %}
provisioner: kubernetes.io/aws-ebs
{% elif cloud_provider == "gcp" %}
provisioner: pd.csi.storage.gke.io
{% elif cloud_provider == "minikube" %}
provisioner: k8s.io/minikube-hostpath
{% elif cloud_provider == "k3s" %}
provisioner: k8s.io/local-path
{% elif cloud_provider == "k3s_longhorn" %}
provisioner: driver.longhorn.io
{% endif %}
{% if cloud_provider == "aws" %}
allowedTopologies:
  enabled: false
  matchLabelExpressions:
    - key: failure-domain.beta.kubernetes.io/zone
      values:
        - "{{ region }}a"
{% endif %}
