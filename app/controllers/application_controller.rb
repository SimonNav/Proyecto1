class ApplicationController < ActionController::Base
  # Solo permite navegadores modernos que soporten imágenes webp, notificaciones push, badges, import maps, CSS nesting y CSS :has.
  allow_browser versions: :modern if respond_to?(:allow_browser)

  # Redirige al usuario a la vista de inicio de sesión después de cerrar sesión
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
