# encoding: UTF-8
jQuery ->
  # Activar el datepicker
  $(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
    $(this).datepicker {
      format: "dd/mm/yyyy",
      weekStart: 1,
      autoclose: true,
      language: 'es'
    }

  # Activar select2
  $('.use-select2').select2 {
    formatNoMatches: (term) ->
      return "Sin resultados"
  }

  # Activar timepicker
  $('.use-timepicker').timepicker { showMeridian: false }

  # Mostrar flash en modals
  flash_messages = $('#flash')
  if flash_messages.html().trim() isnt ""
    bootbox.alert flash_messages.html(), "Cerrar", ->
      flash_messages.slideUp()

# MODAL Dialogs para sobreescribir el comportamiento por defecto de data-confirm
$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously
 
$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  modal_content = "<p class='lead'>Estás seguro que quieres realizar esta acción?</p>"
  content_obj = $('#modal_content') 
  modal_content = content_obj.html() if content_obj.html()?

  html = """
         <div class="modal" id="confirmationDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
             <h3 id="myModalLabel">#{message}</h3>
           </div>
           <div class="modal-body">
             #{modal_content}
           </div>
           <div class="modal-footer">
         			<button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cancelar</button>
    					<button class="btn btn-success confirm">Continuar</button>
           </div>
         </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)