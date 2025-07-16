// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'X in one';

  @override
  String get settings => 'Configuración';

  @override
  String get themeMode => 'Modo de Tema';

  @override
  String get language => 'Idioma';

  @override
  String get accountSettings => 'Configuración de Cuenta';

  @override
  String get updateUsername => 'Actualizar Nombre de Usuario';

  @override
  String get updateEmail => 'Actualizar Correo Electrónico';

  @override
  String get updatePassword => 'Actualizar Contraseña';

  @override
  String get currentPassword => 'Contraseña Actual';

  @override
  String get newPassword => 'Nueva Contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get username => 'Nombre de Usuario';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get english => 'Inglés';

  @override
  String get german => 'Alemán';

  @override
  String get spanish => 'Español';

  @override
  String get editAccountSettings => 'Editar Configuración de Cuenta';

  @override
  String get settingsUpdated => 'Configuración actualizada exitosamente';

  @override
  String errorUpdatingSettings(String error) {
    return 'Error al actualizar la configuración: $error';
  }

  @override
  String get appSettings => 'Configuración de la Aplicación';

  @override
  String get userSettings => 'Configuración de Usuario';

  @override
  String get changeUsername => 'Cambiar Nombre de Usuario';

  @override
  String get changePassword => 'Cambiar Contraseña';

  @override
  String get changeEmail => 'Cambiar Correo Electrónico';

  @override
  String get confirmNewPassword => 'Confirmar Nueva Contraseña';

  @override
  String get usernameChanged => 'Nombre de usuario cambiado exitosamente';

  @override
  String get passwordChanged => 'Contraseña cambiada exitosamente';

  @override
  String get emailChanged => 'Correo electrónico cambiado exitosamente';

  @override
  String get usernameCannotBeEmpty =>
      'El nombre de usuario no puede estar vacío';

  @override
  String get failedToChangeUsername => 'Error al cambiar el nombre de usuario';

  @override
  String get failedToChangePassword => 'Error al cambiar la contraseña';

  @override
  String get failedToChangeEmail => 'Error al cambiar el correo electrónico';

  @override
  String get noUserSignedIn => 'No hay usuario conectado';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get sourceCode => 'Código Fuente';

  @override
  String get tasks => 'Tareas';

  @override
  String get addTask => 'Agregar Tarea';

  @override
  String get taskTitle => 'Título de la Tarea';

  @override
  String get title => 'Título';

  @override
  String get titleRequired => 'El título es requerido';

  @override
  String get description => 'Descripción';

  @override
  String get descriptionOptional => 'Descripción (opcional)';

  @override
  String get category => 'Categoría';

  @override
  String get dueDate => 'Fecha de Vencimiento';

  @override
  String get setDueDate => 'Establecer Fecha de Vencimiento';

  @override
  String get searchTasks => 'Buscar tareas...';

  @override
  String get hideCompleted => 'Ocultar Completadas';

  @override
  String get showCompleted => 'Mostrar Completadas';

  @override
  String get showUncompleted => 'Mostrar Incompletas';

  @override
  String get all => 'Todas';

  @override
  String get noTasks => 'Aún no hay tareas';

  @override
  String get delete => 'Eliminar';

  @override
  String get enterTitle => 'Ingrese el título';

  @override
  String get deleteTask => 'Eliminar Tarea';

  @override
  String get deleteTaskConfirmation =>
      '¿Está seguro de que desea eliminar esta tarea?';

  @override
  String get taskDeleted => 'Tarea eliminada';

  @override
  String get myTasks => 'Mis Tareas';

  @override
  String get edit => 'Editar';

  @override
  String get personal => 'Personal';

  @override
  String get work => 'Trabajo';

  @override
  String get shopping => 'Compras';

  @override
  String get health => 'Salud';

  @override
  String get education => 'Educación';

  @override
  String get finance => 'Finanzas';

  @override
  String get markDone => 'Marcar como Completada';

  @override
  String get markUndone => 'Marcar como Incompleta';

  @override
  String get manageCategories => 'Administrar Categorías';

  @override
  String get addCategory => 'Agregar Categoría';

  @override
  String get categoryName => 'Nombre de Categoría';

  @override
  String get enterCategoryName => 'Ingrese el nombre de la categoría';

  @override
  String get deleteCategory => 'Eliminar Categoría';

  @override
  String get deleteCategoryConfirmation =>
      '¿Está seguro de que desea eliminar esta categoría?';

  @override
  String get add => 'Agregar';

  @override
  String get favorites => 'Favoritos';

  @override
  String get screenshots => 'Capturas de Pantalla';

  @override
  String get camera => 'Cámara';

  @override
  String get addToFavorites => 'Agregar a Favoritos';

  @override
  String get removeFromFavorites => 'Quitar de Favoritos';

  @override
  String get hide => 'Ocultar';

  @override
  String get unhide => 'Mostrar';

  @override
  String get selectCategory => 'Seleccionar Categoría';

  @override
  String get editTask => 'Editar Tarea';

  @override
  String get save => 'Guardar';

  @override
  String get errorSaving => 'Error al guardar la tarea';

  @override
  String get taskUpdated => 'Tarea actualizada exitosamente';

  @override
  String get taskAdded => 'Tarea agregada exitosamente';

  @override
  String get totalTasks => 'Tareas totales';

  @override
  String get active => 'Activas';

  @override
  String get completionRate => 'Tasa de Completado';

  @override
  String get filter => 'Filtro';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get priority => 'Prioridad';

  @override
  String get low => 'Baja';

  @override
  String get medium => 'Media';

  @override
  String get high => 'Alta';

  @override
  String get completed => 'Completadas';

  @override
  String get error => 'Error';

  @override
  String get cancel => 'Cancelar';

  @override
  String get undo => 'Deshacer';

  @override
  String get loading => 'Cargando...';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get uncategorized => 'Sin Categoría';

  @override
  String get retry => 'Reintentar';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get calendar => 'Calendario';

  @override
  String get gallery => 'Galería';

  @override
  String get enterTaskTitle => 'Ingrese título de tarea...';

  @override
  String get addDescriptionOptional => 'Agregar descripción (opcional)...';

  @override
  String get selectDueDate => 'Seleccionar fecha de vencimiento';

  @override
  String get selectTimeOptional => 'Seleccionar hora (opcional)';

  @override
  String get welcomeBack => 'Bienvenido de vuelta';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get loginSubtitle => 'Inicia sesión para continuar';

  @override
  String get signupSubtitle => 'Crea una cuenta para comenzar';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get signup => 'Registrarse';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get dontHaveAccount => '¿No tienes cuenta?';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta?';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get signUpWithGoogle => 'Registrarse con Google';

  @override
  String get or => 'o';

  @override
  String get emailRequired => 'El correo electrónico es requerido';

  @override
  String get invalidEmail => 'Por favor ingrese un correo electrónico válido';

  @override
  String get passwordRequired => 'La contraseña es requerida';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get confirmPasswordRequired => 'Por favor confirme su contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get loginFailed => 'Error al iniciar sesión';

  @override
  String get signupFailed => 'Error al registrarse';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get logoutConfirmation => '¿Está seguro de que desea cerrar sesión?';

  @override
  String get logoutFailed => 'Error al cerrar sesión';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get changePhoto => 'Cambiar Foto';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get chooseFromGallery => 'Elegir de Galería';

  @override
  String get removePhoto => 'Eliminar Foto';

  @override
  String get photoUpdated => 'Foto actualizada exitosamente';

  @override
  String get photoUpdateFailed => 'Error al actualizar foto';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationSettings => 'Configuración de Notificaciones';

  @override
  String get pushNotifications => 'Notificaciones Push';

  @override
  String get emailNotifications => 'Notificaciones por Email';

  @override
  String get soundEnabled => 'Sonido Habilitado';

  @override
  String get vibrationEnabled => 'Vibración Habilitada';

  @override
  String get notificationSettingsUpdated =>
      'Configuración de notificaciones actualizada';

  @override
  String get help => 'Ayuda';

  @override
  String get support => 'Soporte';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get faq => 'Preguntas Frecuentes';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get feedback => 'Comentarios';

  @override
  String get rateApp => 'Calificar App';

  @override
  String get shareApp => 'Compartir App';

  @override
  String get reportBug => 'Reportar Error';

  @override
  String get suggestFeature => 'Sugerir Función';

  @override
  String get thankYou => 'Gracias';

  @override
  String get feedbackSubmitted => 'Comentario enviado exitosamente';

  @override
  String get feedbackFailed => 'Error al enviar comentario';

  @override
  String get search => 'Buscar';

  @override
  String get clear => 'Limpiar';

  @override
  String get apply => 'Aplicar';

  @override
  String get reset => 'Restablecer';

  @override
  String get sort => 'Ordenar';

  @override
  String get group => 'Agrupar';

  @override
  String get view => 'Vista';

  @override
  String get list => 'Lista';

  @override
  String get grid => 'Cuadrícula';

  @override
  String get compact => 'Compacto';

  @override
  String get comfortable => 'Cómodo';

  @override
  String get today => 'Hoy';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get yesterday => 'Ayer';

  @override
  String get thisWeek => 'Esta Semana';

  @override
  String get nextWeek => 'Próxima Semana';

  @override
  String get thisMonth => 'Este Mes';

  @override
  String get nextMonth => 'Próximo Mes';

  @override
  String get overdue => 'Vencida';

  @override
  String get dueSoon => 'Vence Pronto';

  @override
  String get noDueDate => 'Sin Fecha de Vencimiento';

  @override
  String get quickAdd => 'Agregar Rápido';

  @override
  String get quickAddHint => 'Escriba y presione Enter para agregar tarea';

  @override
  String get bulkActions => 'Acciones Masivas';

  @override
  String get selectAll => 'Seleccionar Todo';

  @override
  String get deselectAll => 'Deseleccionar Todo';

  @override
  String get markSelectedDone => 'Marcar Seleccionadas como Completadas';

  @override
  String get deleteSelected => 'Eliminar Seleccionadas';

  @override
  String get moveSelected => 'Mover Seleccionadas';

  @override
  String get copySelected => 'Copiar Seleccionadas';

  @override
  String get exportSelected => 'Exportar Seleccionadas';

  @override
  String get importTasks => 'Importar Tareas';

  @override
  String get exportTasks => 'Exportar Tareas';

  @override
  String get backupTasks => 'Respaldar Tareas';

  @override
  String get restoreTasks => 'Restaurar Tareas';

  @override
  String get syncTasks => 'Sincronizar Tareas';

  @override
  String get syncEnabled => 'Sincronización Habilitada';

  @override
  String get lastSync => 'Última Sincronización';

  @override
  String get syncNow => 'Sincronizar Ahora';

  @override
  String get syncFailed => 'Error de Sincronización';

  @override
  String get syncSuccessful => 'Sincronización Exitosa';

  @override
  String get offline => 'Sin Conexión';

  @override
  String get online => 'En línea';

  @override
  String get connecting => 'Conectando...';

  @override
  String get connectionFailed => 'Error de Conexión';

  @override
  String get checkConnection => 'Verificar Conexión';

  @override
  String get refresh => 'Actualizar';

  @override
  String get pullToRefresh => 'Deslizar para actualizar';

  @override
  String get releaseToRefresh => 'Soltar para actualizar';

  @override
  String get refreshing => 'Actualizando...';

  @override
  String get noInternet => 'Sin Conexión a Internet';

  @override
  String get checkInternet => 'Por favor verifique su conexión a internet';

  @override
  String get tryAgain => 'Intentar de Nuevo';

  @override
  String get close => 'Cerrar';

  @override
  String get done => 'Hecho';

  @override
  String get next => 'Siguiente';

  @override
  String get previous => 'Anterior';

  @override
  String get skip => 'Saltar';

  @override
  String get finish => 'Finalizar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get back => 'Atrás';

  @override
  String get forward => 'Adelante';

  @override
  String get home => 'Inicio';

  @override
  String get menu => 'Menú';

  @override
  String get more => 'Más';

  @override
  String get less => 'Menos';

  @override
  String get expand => 'Expandir';

  @override
  String get collapse => 'Contraer';

  @override
  String get showMore => 'Mostrar Más';

  @override
  String get showLess => 'Mostrar Menos';

  @override
  String get details => 'Detalles';

  @override
  String get summary => 'Resumen';

  @override
  String get preview => 'Vista Previa';

  @override
  String get fullscreen => 'Pantalla Completa';

  @override
  String get exitFullscreen => 'Salir de Pantalla Completa';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get fitToScreen => 'Ajustar a Pantalla';

  @override
  String get actualSize => 'Tamaño Real';

  @override
  String get rotate => 'Rotar';

  @override
  String get flip => 'Voltear';

  @override
  String get crop => 'Recortar';

  @override
  String get brightness => 'Brillo';

  @override
  String get contrast => 'Contraste';

  @override
  String get saturation => 'Saturación';

  @override
  String get blur => 'Desenfocar';

  @override
  String get sharpen => 'Enfocar';

  @override
  String get effects => 'Efectos';

  @override
  String get adjustments => 'Ajustes';

  @override
  String get enhance => 'Mejorar';

  @override
  String get autoEnhance => 'Mejora Automática';

  @override
  String get resetAdjustments => 'Restablecer Ajustes';

  @override
  String get saveChanges => 'Guardar Cambios';

  @override
  String get discardChanges => 'Descartar Cambios';

  @override
  String get unsavedChanges => 'Tiene cambios sin guardar';

  @override
  String get saveBeforeLeaving => '¿Guardar antes de salir?';

  @override
  String get changesSaved => 'Cambios guardados';

  @override
  String get changesDiscarded => 'Cambios descartados';

  @override
  String get permissionRequired => 'Permiso Requerido';

  @override
  String permissionRationale(String permission) {
    return 'Esta aplicación necesita acceso a $permission para funcionar correctamente';
  }

  @override
  String get permissionDenied => 'Permiso Denegado';

  @override
  String permissionDeniedRationale(String permission) {
    return 'Esta función requiere permiso de $permission. Por favor habilítelo en la configuración de su dispositivo.';
  }

  @override
  String get permissionNotGranted => 'Permiso no otorgado';

  @override
  String get allow => 'Permitir';

  @override
  String get deny => 'Denegar';

  @override
  String get openSettings => 'Abrir Configuración';

  @override
  String get cameraPermission => 'Cámara';

  @override
  String get storagePermission => 'Almacenamiento';

  @override
  String get locationPermission => 'Ubicación';

  @override
  String get microphonePermission => 'Micrófono';

  @override
  String get notificationPermission => 'Notificaciones';

  @override
  String get contactsPermission => 'Contactos';

  @override
  String get calendarPermission => 'Calendario';

  @override
  String get phonePermission => 'Teléfono';

  @override
  String get smsPermission => 'SMS';

  @override
  String get callLogPermission => 'Registro de Llamadas';

  @override
  String get bodySensorsPermission => 'Sensores Corporales';

  @override
  String get activityRecognitionPermission => 'Reconocimiento de Actividad';

  @override
  String get healthPermission => 'Datos de Salud';

  @override
  String get bluetoothPermission => 'Bluetooth';

  @override
  String get bluetoothScanPermission => 'Escaneo Bluetooth';

  @override
  String get bluetoothConnectPermission => 'Conexión Bluetooth';

  @override
  String get bluetoothAdvertisePermission => 'Publicidad Bluetooth';

  @override
  String get nearbyWifiDevicesPermission => 'Dispositivos Wi-Fi Cercanos';

  @override
  String get systemAlertWindowPermission => 'Ventana de Alerta del Sistema';

  @override
  String get writeSettingsPermission => 'Escribir Configuración';

  @override
  String get drawOverOtherAppsPermission => 'Dibujar Sobre Otras Apps';

  @override
  String get accessibilityPermission => 'Accesibilidad';

  @override
  String get usageStatsPermission => 'Estadísticas de Uso';

  @override
  String get deviceAdminPermission => 'Administrador de Dispositivo';

  @override
  String get bindNotificationListenerPermission =>
      'Escuchador de Notificaciones';

  @override
  String get bindInputMethodPermission => 'Método de Entrada';

  @override
  String get bindAccessibilityServicePermission => 'Servicio de Accesibilidad';

  @override
  String get bindDeviceAdminPermission => 'Administrador de Dispositivo';

  @override
  String get bindNotificationAssistantServicePermission =>
      'Asistente de Notificaciones';

  @override
  String get bindVoiceInteractionServicePermission => 'Interacción de Voz';

  @override
  String get bindTextServicePermission => 'Servicio de Texto';

  @override
  String get bindAutofillServicePermission => 'Servicio de Autocompletado';

  @override
  String get bindContentSuggestionsServicePermission =>
      'Sugerencias de Contenido';

  @override
  String get bindCompanionDeviceServicePermission => 'Dispositivo Compañero';

  @override
  String get bindInCallServicePermission => 'Servicio de Llamada';

  @override
  String get bindVisualVoicemailServicePermission => 'Buzón de Voz Visual';

  @override
  String get bindNetworkScoreServicePermission => 'Puntuación de Red';

  @override
  String get bindNetworkRecommendationServicePermission =>
      'Recomendación de Red';

  @override
  String get bindVpnServicePermission => 'Servicio VPN';

  @override
  String get bindCarrierMessagingServicePermission => 'Mensajería del Operador';

  @override
  String get bindCarrierServicesPermission => 'Servicios del Operador';

  @override
  String get bindTelecomServicePermission => 'Servicio de Telecomunicaciones';

  @override
  String get bindCallScreeningServicePermission => 'Filtrado de Llamadas';

  @override
  String get bindCallRedirectionServicePermission => 'Redirección de Llamadas';

  @override
  String get bindCallDiagnosticServicePermission => 'Diagnóstico de Llamadas';

  @override
  String get bindCallLogProviderPermission =>
      'Proveedor de Registro de Llamadas';

  @override
  String get bindContactsProviderPermission => 'Proveedor de Contactos';

  @override
  String get bindDirectorySearchPermission => 'Búsqueda de Directorio';

  @override
  String get bindAppWidgetPermission => 'Widget de App';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get wrongPassword => 'Contraseña incorrecta';

  @override
  String get emailInUse => 'El correo electrónico ya está en uso';

  @override
  String get weakPassword => 'La contraseña es muy débil';

  @override
  String get errorOccurred => 'Ocurrió un error';

  @override
  String get enterEmail => 'Ingrese correo electrónico';

  @override
  String get validEmail => 'Por favor ingrese un correo electrónico válido';

  @override
  String get enterPassword => 'Ingrese contraseña';

  @override
  String get passwordLength => 'La contraseña debe tener al menos 6 caracteres';

  @override
  String get typeMessage => 'Escribir mensaje...';

  @override
  String get userTyping => 'Usuario escribiendo…';

  @override
  String get globalChat => 'Chat Global';

  @override
  String get noMessagesYet => 'Aún no hay mensajes';

  @override
  String get notLoggedIn => 'No conectado';

  @override
  String get errorSendingMessage => 'Error al enviar mensaje';

  @override
  String get newMessage => 'Nuevo Mensaje';
}
