resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "dex.enabled"
    value = false
  }
  set {
    name  = "configs.params.server\\.insecure"
    value = true
  }
}

resource "kubernetes_manifest" "sealedsecret_argocd_private_repo_creds" {
  manifest = {
    "apiVersion" = "bitnami.com/v1alpha1"
    "kind"       = "SealedSecret"
    "metadata" = {
      "name"      = "private-repo-creds"
      "namespace" = "argocd"
    }
    "spec" = {
      "encryptedData" = {
        "password" = "AgAUkz37LQcBszk6PdF5itRJ7LPpfSTSQ7BpNj8N+wXLs8HMtE0l5k3kfVoAmGktO49TyAXAAvnhArgrPirhFvDc9zxGK2b46ZcGoJzG9yoVAip7GfG9E/4SVHEZ8TPAAyZ/ESJTZrQW2/5VcBcA1F6lt/Y6KeJhLKSra6xvYNpiy0rYWuvyvlCEaHd9WPjHkv3+jjCGrVg/O5Pu9Sl/rKxq+ac3RXi90irhUCqn0jeo2l0fJ5YrUyAsB9SgkePfPNId1F3NU63V48+tJzz3JHGJqn2JdJ4nKBxCkFBaWZ8EEl0GYa3Tx/mooFolhJDzxWT55cU563+MA6zz9pAcEjbbO1bJbXELPRJjD99tYI+9PY/qOMdMNWX9K8cE3IE2qIx+mM5jxv9VOCgObU3LV4sHtdZpx+NsO6W2wHKkSjkZzu3vFw0lk5tHukx+eLPUeYAgCeyO7mYszu+OvWlnwoQEuWQIqbXJPzysNgxeJB/B9Om8ne9W6zKJFy5C+2gUu/dU+n8SDvqeOC/aZIZMuzForZlg0BXcl98hynaFEjbdbQkS6uu7OoEVnw7lMnY6u5zdglTa+pqF4zeECJvZ7sLTIsY8v+Eqqw1HNybMbZ+TXoVtDzEKZfSXp16xESm44/0DLD9AM+ZPtqbs6yNkbuCwj79xHtxAPMbVeKx0lhtGdNHn9Ypesrm8oYpJnhcxi8gwj3vCXnQP8+1zQ/+7Axf8j1QgIk/lQM8juhdcE7h6thlOH64BKkDyxtYEUTnVdTCjve1z0CjpDeVtvTX6ttLYrD9mOn//gJUC/RHqwXVpK7+42ySfKWdzemVO6QU="
        "type"     = "AgBDc55P57XcnueO84XnkScqfiAeae/USINZ0lxWWu1I2XvHJoxJaAGL6qA37ql/cyaq1MeZzLlLapsqdjoNDwXvciufIQ4rGOeJS8g2sl4jEgF1HLnxfZDkz7qVKxQ6SygnaLSuk89bBdCp4NTUt1CM0YHm3collpj4NAUh+1m7di15Vr1OYQPCXoRgOIIS2V2FGWTgSjiYPb8zRBUiDH/2U+OO0thhflrO2/hardWZnOVuft2cRk0hPLJgLoiaZ82esTTNZCTkXMJQF2fXFk1AqlX+KUwBLvCdBk/wpXdnZgpxCUawRd0Jwu3FrNCMEELc6PkEw3RXSuaUQ7cJEBMqLZdxBepcwFltfx2DKo73ZcexUEIrauZfSCHSBe/aBTJEnm9sqLtQAzfiPF7NQYlI/0NxvNfItylTRH/75gy9gPZ1ZNhnJVfmuEFEzRI08NfZTcP7ly4tnz4eyhvaEcvhnVxHZAAl1lqb1Wi3HlIIKQmzKpd/qkZik73cGLF8SkiBfVQtn0VlzGDUEtKeFZUzUL7htkwFvnbwB0Xz7CO3RuZmxSO2YqefiTqShdPY7Ar14GecHVeDsO5GPvbN7RjVFVBKoytpMVV5Ae8BjcsqOizeSG9NOPJ1I2PnRHWV6sPyo/H4yUNzmf64AolGskEIlGdTup4Fm565q9gqRS7BRG6RQm7yiZW2EaYtrvWL+ytNzoE="
        "url"      = "AgAjSTnnPn4Y0oubpZNhmo0YUhRUHWBVUnZu1oYevBkdkLOYPNvEhSpeoAVNk3VQnDiZBW+o681eQz2i8XADwniSMYlngL3XLy6h4cLFhOhULZJbEO3tEZKGSAug1nLZJXWuPabOXzqvVlY6XbCaOMi7nqHJGBjNRkAFiD0sAiqlbwQ0F41wz3gGW+cuh+tGrlSRlVbnL3wOP5wZZ4k86BgXnAhOw67WVAGyU8ti6S/t+VvRMVk1NqHozC+orWlZ1HJTmY4SYYjr69y9THAZQMBwPJXQIV2m4UBFZcrjchXSXKs+06FuwcB00ENocxX04UQNACTotZu+0MY8Af3R3K+EyHietQSmqkrzKFdInGSsU+uwaCHt23z+pRtEXpvuPgjfUm2ntB0gxp+8osW3moNnAoqjw+BDGqsMLZXtSkXwFyD+EnLq1S98JoB1BB2BnF+FT5TZSwtFfoRzupGbnbk39AGYxKy75aLK3HdfxsCxzgsu21Na2yk5WeZ4CBXs068cadfmcVJwlC3ePofAop4W6VFPF2WQPCen4h1B4naA8BVOVNXHMlRDgCVH+wlJil5TZGC5d6mRcpWTSODxMhWU9f3dOryIz5u4k7intTT0jEIXo1NvGYUpz8Apeqp5rkpQ+lxiwehZomkv/uR9s7078iTw7NMqY20D/180ghSiy0c21BQVh6bKFZp+bozcP7fQGho7MsvrwXh6LKpG86KvpJfjXPcs/sLbMGSOa8T1Iw=="
        "username" = "AgAK5X+5fehD8szDuqtLOZaMJa+rrLdkjBVtQXLpEQ7tZfUjxvgm339iqSkKZDB0F7/O302mnkD5ERWTqYfLBpPlZj6Fylx2mWza7dy6yiXf/di7bibU8OuuetClrvKF1i7vKxrjNxBnYAFvlROZwRuiwugxiw30xYdVhma/Y4tUP52JUk53yey70PHQM8I9oTFcJq+TWUAj99vd2GeBdxJegLoCmhufU2mWfCiiodnbGtHF005SRglm3ATfrdM0CBYOaDl5nQXvppyLe7fuTEfOP3lXmevPABvZwbez1aGuA/cRzO/0lAj0/zOeBHf+Z0Kc2Gb5bXXo4ym70sU5TQdglqOjMd099jr4qoWq8ABnD3ZnzJKRF/3noVBtdMMrmFlQhMRkyqkOZit3GsoXSQF94BfzQUu9khtBzVtMRPVOgLF8WolhETUNJUaEwPIuuVexCa1eDx5KQ5INSX36EgDys8FrM0cQzCciuHM+HkgyXI5QmTy7824HfNadMTZVCiIp4GM0YTofQHVa5DVOWMJZ7waEYTtQ9MZQEg/bvEz60cvKjutbdL06m9I4it34yKBXqZlrfmE7IbivQcALSgoA16hqFC3T0Ivou7wqHdx780q1bTA8+2xnU4DmIoSqoau2DvMwK2H5ElQ/5Q9j5humPj+gnGihsOW4SKAcm9lPQ/0wuLh/+uo1yIKD8yN0Ckm7wWxefkOoOFpfPjfo"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "argocd.argoproj.io/secret-type" = "repo-creds"
          }
          "name"      = "private-repo-creds"
          "namespace" = "argocd"
        }
        "type" = "Opaque"
      }
    }
  }
}
