# proxy-hares

Reverse proxy de entrada de **HARE-S** (Gestión y Catálogo de Pruebas de Lectura y Rendimiento Escolar).

Es el **único punto de entrada** del sistema: recibe todo el tráfico HTTP, enruta `/api/*` hacia el backend y el resto hacia el frontend. Ningún otro servicio publica puertos al exterior.

## Responsabilidad

- Enrutar `/api/` → `backend:5000`
- Enrutar el resto → `frontend:80`
- Headers de seguridad
- Límite de subida (`client_max_body_size 10m`)
- HTTPS/SSL en producción (bloque comentado, listo para activar)

Relacionado:
- `../infra-hares/docker-compose.yml` orquesta el stack y construye esta imagen con `build: ../proxy-hares`.
- La configuración del servidor de estáticos del frontend vive en `../front-hares/nginx.conf` (no es el proxy).

## Estructura

```
proxy-hares/
├── Dockerfile                  # imagen nginx con nginx.conf
├── nginx.conf                  # reverse proxy (upstreams + locations)
├── scripts/
│   └── generate-ssl.sh         # certificados autofirmados para desarrollo/testing
└── guide/
    └── https-setup.md          # cómo activar HTTPS
```

## Uso

El proxy se construye y levanta desde **`infra-hares`**:

```bash
cd ../infra-hares
docker compose up -d proxy
```

## Verificación de la configuración

```bash
docker compose exec proxy nginx -t
```