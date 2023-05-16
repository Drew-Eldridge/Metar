import Scenes
import Foundation
import Igis
  /*
     This class is responsible for the foreground Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class ForegroundLayer : Layer {
    let metar = MetarData.metar!
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")
        for met in metar {
            guard let altim_in_hg = met.altim_in_hg,
                  let dewpoint_c = met.dewpoint_c,
                  let temp_c = met.temp_c else {
                continue
            }
            
            let plot = Station(
              x: coords(latitude: met.latitude!, longitude: met.longitude!, Xsize: 1903.0, Ysize: 937.0).x,
              y: coords(latitude: met.latitude!, longitude: met.longitude!, Xsize: 1903.0, Ysize: 937.0).y,
              size: 14,
              station_id: met.station_id,
              wind_barb_direction: 45.0,
              wind_barb_speed:15,
              altim_in_hg: met.altim_in_hg!,
              dew_point: met.dewpoint_c!,
              visibility: met.visibility_statute_mi,
              precip: met.wx_string,
              precip_in: met.precip_in,
              pcp3hr_in: met.pcp3hr_in,
              pcp6hr_in: met.pcp6hr_in,
              pcp24hr_in: met.pcp24hr_in,
              snow_in: met.snow_in,
              sky_cover1: met.sky_cover1,
              sky_cover2: met.sky_cover2,
              sky_cover3: met.sky_cover3,
              sky_cover4: met.sky_cover4,
              flight_category: met.flight_category,
              temp_c: met.temp_c!,
              ceiling:met.cloud_base_ft_agl1,
              cloud_base_ft_agl1: met.cloud_base_ft_agl1,
              cloud_base_ft_agl2: met.cloud_base_ft_agl2,
              cloud_base_ft_agl3: met.cloud_base_ft_agl3,
              cloud_base_ft_agl4: met.cloud_base_ft_agl4
            )
//            print(coords(latitude: met.latitude!, longitude: met.longitude!, Xsize: 1903.0, Ysize: 937.0))
//            print(met.latitude)
//            print(met.longitude)
            print(met.wx_string)
            insert(entity: plot, at:.front)
        }
        
        
        //         let plot = Station(x: 100, y: 100, size: 10, station_id: "KJFK", wind_barb_direction: 45.0, wind_barb_speed: 15, altim_in_hg: 29.92, dew_point: 12.5, visibility: 10, precip: 0.0, precip_in: nil, pcp3hr_in: nil, pcp6hr_in: nil, pcp24hr_in: nil, snow_in: nil, sky_cover1: "BKN", sky_cover2: "BKN", sky_cover3: nil, sky_cover4: nil, flight_category: "VFR", temp_c: 20.0, ceiling: 5000.0, cloud_base_ft_agl1: 3000, cloud_base_ft_agl2: 4000, cloud_base_ft_agl3: nil, cloud_base_ft_agl4: nil)
    }
    func coords(latitude: Double, longitude: Double, Xsize: Double, Ysize: Double) -> (x:Int, y:Int) {
        let x = (((longitude + 180) * (Xsize / 360) * 5.5) - Xsize * 3/4)
        let y = ((90 - latitude) * (Ysize / 180) * 5.5) - Ysize * 43/40
        return (x:Int(x),y:Int(y))
    }
}
