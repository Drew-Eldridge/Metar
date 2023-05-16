import Foundation

class Metar {

    let raw_text: String
    let station_id: String
    let observation_time: String?
    let latitude: Double?
    let longitude: Double?
    let temp_c: Double?
    let dewpoint_c: Double?
    let wind_dir_degrees: Int?
    let wind_speed_kt: Int?
    let wind_gust_kt: Int?
    let visibility_statute_mi: Double?
    let altim_in_hg: Double? 
    let sea_level_pressure_mb: Double?
    let corrected: Bool?
    let auto: Bool?
    let auto_station: Bool?
    let maintenance_indicator_on: Bool?
    let no_signal: Bool?
    let lightning_sensor_off: Bool?
    let freezing_rain_sensor_off: Bool?
    let present_weather_sensor_off: Bool?
    let wx_string: String?
    let sky_cover1: String?
    let cloud_base_ft_agl1: Int?
    let sky_cover2: String?
    let cloud_base_ft_agl2: Int?
    let sky_cover3: String?
    let cloud_base_ft_agl3: Int?
    let sky_cover4: String?
    let cloud_base_ft_agl4: Int?
    let flight_category: String?
    let three_hr_pressure_tendency_mb: Double?
    let maxT_c: Double?
    let minT_c: Double?
    let maxT24hr_c: Double?
    let minT24hr_c: Double?
    let precip_in: Double?
    let pcp3hr_in: Double?
    let pcp6hr_in: Double?
    let pcp24hr_in: Double?
    let snow_in: Double?
    let vert_vis_ft: Int?
    let metar_type: String?
    let elevation_m: Double?

    init(raw_text: String, station_id: String, observation_time: String?, latitude: Double?, longitude: Double?, temp_c: Double?, dewpoint_c: Double?, wind_dir_degrees: Int?, wind_speed_kt: Int?, wind_gust_kt: Int?, visibility_statute_mi: Double?, altim_in_hg: Double?, sea_level_pressure_mb: Double?, corrected: Bool?, auto: Bool?, auto_station: Bool?, maintenance_indicator_on: Bool?, no_signal: Bool?, lightning_sensor_off: Bool?, freezing_rain_sensor_off: Bool?, present_weather_sensor_off: Bool?, wx_string: String?, sky_cover1: String?, cloud_base_ft_agl1: Int?, sky_cover2: String?, cloud_base_ft_agl2: Int?, sky_cover3: String?, cloud_base_ft_agl3: Int?, sky_cover4: String?, cloud_base_ft_agl4: Int?, flight_category: String?, three_hr_pressure_tendency_mb: Double?, maxT_c: Double?, minT_c: Double?, maxT24hr_c: Double?, minT24hr_c: Double?, precip_in: Double?, pcp3hr_in: Double?, pcp6hr_in: Double?, pcp24hr_in: Double?, snow_in: Double?, vert_vis_ft: Int?, metar_type: String?, elevation_m: Double?) {
        self.raw_text = raw_text
        self.station_id = station_id
        self.observation_time = observation_time
        self.latitude = latitude
        self.longitude = longitude
        self.temp_c = temp_c
        self.dewpoint_c = dewpoint_c
        self.wind_dir_degrees = wind_dir_degrees
        self.wind_speed_kt = wind_speed_kt
        self.wind_gust_kt = wind_gust_kt
        self.visibility_statute_mi = visibility_statute_mi
        self.altim_in_hg = altim_in_hg
        self.sea_level_pressure_mb = sea_level_pressure_mb
        self.corrected = corrected
        self.auto = auto
        self.auto_station = auto_station
        self.maintenance_indicator_on = maintenance_indicator_on
        self.no_signal = no_signal
        self.lightning_sensor_off = lightning_sensor_off
        self.freezing_rain_sensor_off = freezing_rain_sensor_off
        self.present_weather_sensor_off = present_weather_sensor_off
        self.wx_string = wx_string
        self.sky_cover1 = sky_cover1
        self.cloud_base_ft_agl1 = cloud_base_ft_agl1
        self.sky_cover2 = sky_cover2
        self.cloud_base_ft_agl2 = cloud_base_ft_agl2
        self.sky_cover3 = sky_cover3
        self.cloud_base_ft_agl3 = cloud_base_ft_agl3
        self.sky_cover4 = sky_cover4
        self.cloud_base_ft_agl4 = cloud_base_ft_agl4
        self.flight_category = flight_category
        self.three_hr_pressure_tendency_mb = three_hr_pressure_tendency_mb
        self.maxT_c = maxT_c
        self.minT_c = minT_c
        self.maxT24hr_c = maxT24hr_c
        self.minT24hr_c = minT24hr_c
        self.precip_in = precip_in
        self.pcp3hr_in = pcp3hr_in
        self.pcp6hr_in = pcp6hr_in
        self.pcp24hr_in = pcp24hr_in
        self.snow_in = snow_in
        self.vert_vis_ft = vert_vis_ft
        self.metar_type = metar_type
        self.elevation_m = elevation_m
    }

    convenience init(raw_text: String, station_id: String, observation_time: String, latitude: String, longitude: String, temp_c: String, dewpoint_c: String, wind_dir_degrees: String, wind_speed_kt: String, wind_gust_kt: String, visibility_statute_mi: String, altim_in_hg: String, sea_level_pressure_mb: String, corrected: String, auto: String, auto_station: String, maintenance_indicator_on: String, no_signal: String, lightning_sensor_off: String, freezing_rain_sensor_off: String, present_weather_sensor_off: String, wx_string: String, sky_cover1: String, cloud_base_ft_agl1: String, sky_cover2: String, cloud_base_ft_agl2: String, sky_cover3: String, cloud_base_ft_agl3: String, sky_cover4: String, cloud_base_ft_agl4: String, flight_category: String, three_hr_pressure_tendency_mb: String, maxT_c: String, minT_c: String, maxT24hr_c: String, minT24hr_c: String, precip_in: String, pcp3hr_in: String, pcp6hr_in: String, pcp24hr_in: String, snow_in: String, vert_vis_ft: String, metar_type: String, elevation_m: String) {
        self.init(raw_text: String(raw_text),
                  station_id: String(station_id),
                  observation_time: String(observation_time),
                  latitude: Double(latitude),
                  longitude: Double(longitude),
                  temp_c: Double(temp_c),
                  dewpoint_c: Double(dewpoint_c),
                  wind_dir_degrees: Int(wind_dir_degrees),
                  wind_speed_kt: Int(wind_speed_kt),
                  wind_gust_kt: Int(wind_gust_kt),
                  visibility_statute_mi: Double(visibility_statute_mi),
                  altim_in_hg: Double(altim_in_hg),
                  sea_level_pressure_mb: Double(sea_level_pressure_mb),
                  corrected: Bool(corrected),
                  auto: Bool(auto),
                  auto_station: Bool(auto_station),
                  maintenance_indicator_on: Bool(maintenance_indicator_on),
                  no_signal: Bool(no_signal),
                  lightning_sensor_off: Bool(lightning_sensor_off),
                  freezing_rain_sensor_off: Bool(freezing_rain_sensor_off),
                  present_weather_sensor_off: Bool(present_weather_sensor_off),
                  wx_string: String(wx_string),
                  sky_cover1: String(sky_cover1), cloud_base_ft_agl1: Int(cloud_base_ft_agl1),
                  sky_cover2: String(sky_cover2), cloud_base_ft_agl2: Int(cloud_base_ft_agl2),
                  sky_cover3: String(sky_cover3), cloud_base_ft_agl3: Int(cloud_base_ft_agl3),
                  sky_cover4: String(sky_cover4), cloud_base_ft_agl4: Int(cloud_base_ft_agl4),
                  flight_category: String(flight_category),
                  three_hr_pressure_tendency_mb: Double(three_hr_pressure_tendency_mb),
                  maxT_c: Double(maxT_c), minT_c: Double(minT_c),
                  maxT24hr_c: Double(maxT24hr_c), minT24hr_c: Double(minT24hr_c),
                  precip_in: Double(precip_in),
                  pcp3hr_in: Double(pcp3hr_in), pcp6hr_in: Double(pcp6hr_in), pcp24hr_in: Double(pcp24hr_in),
                  snow_in: Double(snow_in),
                  vert_vis_ft: Int(vert_vis_ft),
                  metar_type: String(metar_type),
                  elevation_m: Double(elevation_m))
        }

    convenience init?(line: String) {

        let fields = line.components(separatedBy: ",")
        guard fields.count == 44 else {
            print("Unexpected list of fields in \(line)")
            return nil
        }
      
        self.init(raw_text: fields[0],
                  station_id: fields[1],
                  observation_time: fields[2],
                  latitude: fields[3],
                  longitude: fields[4],
                  temp_c: fields[5],
                  dewpoint_c: fields[6],
                  wind_dir_degrees: fields[7],
                  wind_speed_kt: fields[8],
                  wind_gust_kt: fields[9],
                  visibility_statute_mi: fields[10],
                  altim_in_hg: fields[11],
                  sea_level_pressure_mb: fields[12],
                  corrected: fields[13],
                  auto: fields[14],
                  auto_station: fields[15],
                  maintenance_indicator_on: fields[16],
                  no_signal: fields[17],
                  lightning_sensor_off: fields[18],
                  freezing_rain_sensor_off: fields[19],
                  present_weather_sensor_off: fields[20],
                  wx_string: fields[21],
                  sky_cover1: fields[22],
                  cloud_base_ft_agl1: fields[23],
                  sky_cover2: fields[24],
                  cloud_base_ft_agl2: fields[25],
                  sky_cover3: fields[26],
                  cloud_base_ft_agl3: fields[27],
                  sky_cover4: fields[28],
                  cloud_base_ft_agl4: fields[29],
                  flight_category: fields[30],
                  three_hr_pressure_tendency_mb: fields[31],
                  maxT_c: fields[32],
                  minT_c: fields[33],
                  maxT24hr_c: fields[34],
                  minT24hr_c: fields[35],
                  precip_in: fields[36],
                  pcp3hr_in: fields[37],
                  pcp6hr_in: fields[38],
                  pcp24hr_in: fields[39],
                  snow_in: fields[40],
                  vert_vis_ft: fields[41],
                  metar_type: fields[42],
                  elevation_m: fields[43])        
    }
}
extension Metar: CustomStringConvertible {
    var description: String {
        return "station_id: \(station_id), observation_time: \(observation_time!), temp_c: \(temp_c!)"
    }
}

let filePath = "./Example-metars.csv"
let fileURL = URL(fileURLWithPath:filePath.expandingTildeInPath)

func getMetars() {
    var lines : [String] = []
    print("Loading \(filePath)")
    do {
        let contents = try String(contentsOf: fileURL)
        for line in contents.components(separatedBy:"\n") {
            lines.append(line)
        }    
    } catch {
        print("failed lol due to \(error)")
    }
    for i in 5 ..< 8 {
        let station = Metar(line:lines[i])
        if let output = station {
            print(output)
        }
    }
}

func readTextFile(atPath filePath: String) -> [String]? {
    do {
        let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
        let lines = fileContents.components(separatedBy: .newlines)
        
        return lines
    } catch {
        print("Error reading file: \(error.localizedDescription)")
        return nil
    }
}

func takeFile(atPath filePath: String) -> [Metar]? {

    if let fileContents = readTextFile(atPath: filePath) {
        //print(fileContents) //debugging
        var metar: [Metar] = []
        for x in 5 ..< 103 {
//        for fileContent in fileContents {
            metar.append(Metar(line: fileContents[x])!)
        }
        return metar
    
    } else {
        print("Failed to read file.")
        return nil
    }
}


let createMetar = takeFile(atPath: filePath)

struct MetarData {
    static var metar = createMetar
}
