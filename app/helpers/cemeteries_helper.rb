# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Cemetery defines helper methods used by cemetery controller and views
# ##############################################################################

module CemeteriesHelper

# method uses ActionController and Gmaps4Rails model to build markers based on
# latitude and longitudinal values provided from an object
# @param: object/instance with latitude and longitude values (ie cemeteries)
# @return: marker hash containing lat and long values used by JS scripts to
# produce pin-points with info windows on a Google Maps instance
def add_markers(object)
  # use ActionController to create object instance to use render_to_string method
  info = ActionController::Base.new()
  @markers_hash = Gmaps4rails.build_markers(object) do |cem, marker|
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
