module CemeteriesHelper

def add_markers
  # use ActionController to create object instance to use render_to_string method
  info = ActionController::Base.new()
  @cemeteries = Cemetery.all
  @markers_hash = Gmaps4rails.build_markers(@cemeteries) do |cem, marker|
    if cem.lat != 0 && cem.long != 0
      # set long and lat from cem object
      marker.lat cem.lat
      marker.lng cem.long
      # set infor window to paritil view, pass cem object and path to partial
      marker.infowindow info.render_to_string(:partial => 'cemeteries/infowindow', :locals => {:cemetery => cem, path: cemetery_path(:id => cem.id_cem_lev)})
    end
  end
  return @markers_hash

end



end
