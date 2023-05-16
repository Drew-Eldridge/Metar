
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

            let plot = StationPlot(
              x: coords(latitude: met.latitude!, longitude: met.longitude!, Xsize: 1368.0, Ysize: 920.0).x,
              y: coords(latitude: met.latitude!, longitude: met.longitude!, Xsize: 1920.0, Ysize: 912.0).y,
              
              size: 14,
              station_id: met.station_id,
              wind_dir_degrees: met.wind_dir_degrees ?? 0,
              wind_speed_kt: met.wind_speed_kt ?? 0,
              wind_gust_kt: met.wind_gust_kt ?? 0,
              altim_in_hg: altim_in_hg,
              dewpoint_c: dewpoint_c,
              visibility: 10,
              precip:  met.wx_string,
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
              temp_c: temp_c,
              ceiling: met.cloud_base_ft_agl1,
              cloud_base_ft_agl1: met.cloud_base_ft_agl1,
              cloud_base_ft_agl2: met.cloud_base_ft_agl2,
              cloud_base_ft_agl3: met.cloud_base_ft_agl3,
              cloud_base_ft_agl4: met.cloud_base_ft_agl4
            )
            
            //            print(coords(latitude: met.latitude!, longitude: met.longitude!))
            insert(entity: plot, at:.front)
        }
    }    
    func coords(latitude: Double, longitude: Double, Xsize: Double, Ysize: Double) -> (x:Int, y:Int) {
        let x = (((longitude + 180) * (Xsize / 360) * 5.5) - Xsize * 3/4) - 75
        let y = ((90 - latitude) * (Ysize / 180) * 5.5) - Ysize * 43/40 - 75
        return (x:Int(x),y:Int(y))
    } 
     
} 
    
 

