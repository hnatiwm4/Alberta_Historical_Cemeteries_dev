module CemeteriesHelper

def add_markers
  @cemeteries = Cemetery.all
  @markers_hash = Gmaps4rails.build_markers(@cemeteries) do |cem, marker|
    if cem.lat != 0 && cem.long != 0 
      marker.lat cem.lat
      marker.lng cem.long
    end
  end
  return @markers_hash
end


end
