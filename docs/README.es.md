## Versión en Español

- [Click here for the English version](../README.md)

# Hands-On DevOps: Vagrant + Shell Provisioning

> Una infraestructura local completamente automatizada usando Vagrant y provisión mediante scripts en Bash. Incluye sitios estáticos multilingües y herramientas Docker para extender su funcionalidad.
>
> *Creado como parte del reto [90 Días de DevOps con Roxs](https://github.com/roxsross/90daysdevopsbyroxs).*
>
> *→ Puedes ver mi [diario técnico](https://github.com/DevLizOps/hands-on-devops-90days-logbook) donde documento mi proceso a lo largo del reto.*

> [!NOTE]
> Este proyecto no está afiliado oficialmente a Roxs ni al programa original. Solo refleja mis conocimientos y aprendizaje.

## 📦 Sobre este proyecto

Este proyecto muestra cómo aprovisionar una máquina virtual (VM) usando **Vagrant** con **scripts en Bash**, aplicando conceptos clave de DevOps como la reproducibilidad, automatización e Infraestructura como Código (IaC).

Al iniciar, la máquina virtual se configura con:

- ✅ **Nginx**, sirviendo un sitio web estático sencillo (disponible en inglés o español).
- ✅ **Docker**, preinstalado y listo para ejecutar contenedores.
- ✅ **kubectl**, incluido como preparación para futuras pruebas con Kubernetes.

Todo el aprovisionamiento se realiza mediante **scripts en shell**, reforzando la reproducibilidad y demostrando los principios de Infraestructura como Código en un entorno mínimo pero extensible.

Cada entorno (`vm-en/`, `vm-es/`) es aislado y configurable, mostrando cómo escalar configuraciones mediante provisión modular.

## 🛠️ ¿Por qué usar Vagrant?

**Vagrant** facilita la creación y configuración de entornos de desarrollo automatizando el despliegue de máquinas virtuales con código reproducible. En este proyecto:

- El `Vagrantfile` define la infraestructura de la VM (sistema operativo, red, carpetas sincronizadas y lógica de aprovisionamiento).
- Los **scripts en Bash** actúan como herramientas de provisión que aseguran que la VM alcance un estado deseado.

> Usar scripts en shell permite un control total sobre la instalación de paquetes y la configuración del sistema, sin depender de herramientas externas.

## 🧰 Requisitos

Antes de empezar, asegúrate de tener instaladas las siguientes herramientas:

- [VirtualBox](https://www.virtualbox.org/) – hipervisor para las máquinas virtuales.
- [Vagrant](https://developer.hashicorp.com/vagrant) – herramienta para gestión de infraestructuras.

> [!TIP]
> ⚠️ **¿Usas WSL2?** Ten en cuenta que VirtualBox **no funciona bien dentro de WSL2**, y Vagrant tampoco puede gestionar máquinas correctamente desde ese entorno.
>
> Después de varios intentos fallidos de integración (instalaciones cruzadas, alias, plugins…), opté por una configuración más robusta:
>
> 👉 Toda la virtualización (Vagrant + VirtualBox) se gestiona desde **Windows**, mientras que el entorno Linux (WSL2) lo uso para desarrollo y edición de archivos.
>
> 🔗 [Lee el análisis completo en mi Logbook](https://github.com/DevLizOps/hands-on-devops-90days-logbook)


## 📁 Estructura del proyecto

```
hands-on-devops-vagrant-shell-provisioning/
├── vm-en/
│   ├── Vagrantfile
│   ├── static_website/
│   │   ├── index.html
│   │   └── styles.css
│   └── scripts/
│       ├── install_docker.sh
│       └── install_nginx.sh
├── vm-es/
│   ├── Vagrantfile
│   ├── static_website/
│   │   ├── index.html
│   │   └── styles.css
│   └── scripts/
│       ├── install_docker.sh
│       └── install_nginx.sh
```

## 🔍 Componentes clave

Cada carpeta (`vm-en` y `vm-es`) contiene una definición de VM y lógica de aprovisionamiento completamente aisladas, lo que permite que la misma infraestructura base sirva contenido en distintos idiomas:

- `Vagrantfile`:
  Define la configuración de la máquina (box, red, scripts de provisión). Cada carpeta tiene su propio archivo.

- **Scripts de provisión**:

  - `install_nginx.sh`: instala Nginx y despliega el sitio web en `/var/www/html/`.
  - `install_docker.sh`: instala Docker y kubectl, preparando el sistema para ejecutar contenedores.

- **Sitio estático**:
  Una página web multilingüe básica que valida la configuración del servidor. Puedes ampliarla con historias DevOps o paneles de monitoreo.

Esta separación por componentes asegura que cada script sea claro, mantenible y fácil de extender.

## 🌐 Configuración de red

La VM utiliza una **red privada** con una IP fija:

```ruby
config.vm.network "private_network", ip: "192.168.56.7"
```

Esto garantiza un acceso predecible desde tu máquina anfitriona, sin interferencias con DHCP.
Una vez la VM esté en ejecución, puedes acceder al sitio web en: http://192.168.56.7.

## 🚀 Cómo empezar

### 1. **Clonar el repositorio**

```bash
git clone https://github.com/DevLizOps/hands-on-devops-vagrant-shell-provisioning.git
cd hands-on-devops-vagrant-shell-provisioning/vm-es
```

### 2. **Levantar la máquina virtual**

```bash
vagrant up
```

Esto hará lo siguiente:

- Descargar la imagen base Ubuntu 22.04 (si no está en caché).
- Iniciar la máquina virtual.
- Copiar los archivos del sitio web dentro de la VM.
- Ejecutar los scripts de provisión automáticamente.

### 3. **Abrir el sitio web**

Abre tu navegador en: http://192.168.56.7.

> Esta IP está configurada como red privada en el `Vagrantfile`.

![demo](assets/preview_website.png)

### 4. **Acceder a la máquina virtual**

Si deseas explorar la máquina virtual o ejecutar comandos manuales, accede por SSH:

```bash
vagrant ssh
```

Podrás verificar herramientas instaladas, ver registros o seguir experimentando dentro de la VM.

## 🧪 Pasos de validación

Dentro de la VM:

- Ejecuta `nginx --version` para confirmar la instalación del servidor web.
- Ejecuta `docker --version` y `kubectl version --client` para confirmar que las herramientas están listas.
- Revisa la ruta `/var/www/html` para verificar que el sitio se haya desplegado correctamente.

## 🧹 Apagar y limpiar

Cuando termines de usar la VM, puedes detenerla o eliminarla con:

```bash
vagrant halt    # Detiene la VM de forma segura
vagrant destroy # Elimina completamente la VM y sus recursos
```

Esto ayuda a mantener tu sistema limpio y a liberar espacio en disco.

## 🧤 Claves hands-on

- Crear entornos reproducibles con Vagrant.
- Aprovisionar la infraestructura mediante scripts en Bash.
- Configurar servidores web y preparar sistemas para contenerización.
- Estructurar entornos bilingües de forma modular.
- Depurar procesos de provisión y gestionar el ciclo de vida de máquinas virtuales.

## 📄 Licencia

Este proyecto está licenciado bajo la [Licencia MIT](../LICENSE).
Puedes usarlo, adaptarlo y compartirlo libremente con la atribución adecuada.

> 🌱 Siéntete libre de personalizar el sitio estático o añadir más servicios en la VM para reflejar tu experiencia y aprendizaje en DevOps.
