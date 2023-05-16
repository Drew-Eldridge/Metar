import Scenes
import Igis
import Foundation

class Station : RenderableEntity {
    var didDraw = false
    let x : Int
    let y : Int
    let size : Int
    let station_id : String
    let wind_barb_direction: Double
    let wind_barb_speed: Int
    let altim_in_hg: Double
    let dew_point: Double
    let visibility: Double?
    let precip : String?
    let precip_in: Double?
    let pcp3hr_in: Double?
    let pcp6hr_in: Double?
    let pcp24hr_in: Double?
    let snow_in: Double?
    let sky_cover1: String?
    let sky_cover2: String?
    let sky_cover3: String?
    let sky_cover4: String?
    let flight_category: String?
    let temp_c: Double
    let ceiling: Int?
    let cloud_base_ft_agl1: Int?
    let cloud_base_ft_agl2: Int?
    let cloud_base_ft_agl3: Int?
    let cloud_base_ft_agl4: Int?
    
    let path1 = Path(fillMode:.fill)
    let path2 = Path(fillMode:.fill)
    let path3 = Path(fillMode:.fill)
    let path4 = Path(fillMode:.fill)

    let lrain : Image
    let mrain : Image
    let hrain : Image
    let lsnow : Image
    let msnow : Image
    let hsnow : Image
    let mist : Image
    let drizzle : Image    
 
    init(x: Int, y: Int, size: Int=30, station_id: String, wind_barb_direction: Double, wind_barb_speed: Int, altim_in_hg: Double, dew_point: Double, visibility: Double?, precip: String?, precip_in: Double?, pcp3hr_in: Double?, pcp6hr_in: Double?, pcp24hr_in: Double?, snow_in: Double?, sky_cover1: String?, sky_cover2: String?, sky_cover3: String?, sky_cover4: String?, flight_category: String?, temp_c: Double, ceiling: Int?, cloud_base_ft_agl1: Int?, cloud_base_ft_agl2: Int?, cloud_base_ft_agl3: Int?, cloud_base_ft_agl4: Int?) {
        self.x = x
        self.y = y
        self.size = size
        self.station_id = station_id
        self.wind_barb_direction = wind_barb_direction
        self.wind_barb_speed = wind_barb_speed
        self.altim_in_hg = altim_in_hg
        self.dew_point = dew_point
        self.visibility = visibility
        self.precip = precip
        self.precip_in = precip_in
        self.pcp3hr_in = pcp3hr_in
        self.pcp6hr_in = pcp6hr_in
        self.pcp24hr_in = pcp24hr_in
        self.snow_in = snow_in
        self.sky_cover1 = sky_cover1
        self.sky_cover2 = sky_cover2
        self.sky_cover3 = sky_cover3
        self.sky_cover4 = sky_cover4
        self.flight_category = flight_category
        self.temp_c = temp_c
        self.ceiling = ceiling
        self.cloud_base_ft_agl1 = cloud_base_ft_agl1
        self.cloud_base_ft_agl2 = cloud_base_ft_agl2
        self.cloud_base_ft_agl3 = cloud_base_ft_agl3
        self.cloud_base_ft_agl4 = cloud_base_ft_agl4
        guard let lrainURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=-RA") else {
            fatalError("NO MAP")
        } 
        lrain = Image(sourceURL:lrainURL)

        guard let mrainURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=RA") else {
            fatalError("NO MAP")
        }
        mrain = Image(sourceURL:mrainURL)

        guard let hrainURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=%2BRA") else {
            fatalError("NO MAP")
        } 
        hrain = Image(sourceURL:hrainURL)

        guard let lsnowURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=-SN") else {
            fatalError("NO MAP")
        } 
        lsnow = Image(sourceURL:lsnowURL)

        guard let msnowURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=SN") else {
            fatalError("NO MAP")
        } 
        msnow = Image(sourceURL:msnowURL)

        guard let hsnowURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=%2BSN") else {
            fatalError("NO MAP")
        } 
        hsnow = Image(sourceURL:hsnowURL)

        guard let mistURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=BR") else {
            fatalError("NO MAP")
        } 
        mist = Image(sourceURL:mistURL)
        
        guard let drizzleURL = URL(string:"https://www.aviationweather.gov/cgi-bin/plot/wxicon.php?scale=1.5&code=-DZ") else {
            fatalError("NO MAP")
        } 
        drizzle = Image(sourceURL:drizzleURL)

        super.init(name:"Station")
    }

    func flightColor(_ category: String?) -> Color {
        guard let category = category else { return Color(.black) }
        switch category {
        case "VFR":
            return Color(.green)
        case "MVFR":
            return Color(.blue)
        case "IFR":
            return Color(.red)
        case "LIFR":
            return Color(.magenta)
        default:
            return Color(.black)
        }                         
    }

    func Triangle(canvas:Canvas,fillStyle:FillStyle,leftpoint: DoublePoint,toppoint: DoublePoint,rightpoint:DoublePoint,triangle:Path) {
        //Triangle
        triangle.lineTo(Point(leftpoint))
        triangle.lineTo(Point(toppoint))
        triangle.lineTo(Point(rightpoint))
        triangle.lineTo(Point(leftpoint))
        triangle.moveTo(Point(rightpoint))
        canvas.render(fillStyle,triangle)
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(lrain, mrain, hrain, lsnow, msnow, hsnow, mist, drizzle)
    }
    override func render(canvas: Canvas) {
        if lrain.isReady && mrain.isReady && hrain.isReady && lsnow.isReady && msnow.isReady && hsnow.isReady && mist.isReady && drizzle.isReady{
            let fillStyle = FillStyle(color:flightColor(flight_category))
            let strokeStyle = StrokeStyle(color:flightColor(flight_category))
            canvas.render(fillStyle, strokeStyle)

            let circle = Ellipse(center:Point(x: x, y: y), radiusX: size, radiusY: size, fillMode: .stroke)        
            let fullcircle = Ellipse(center:Point(x: x, y: y), radiusX: size, radiusY: size, fillMode: .fill)        
            
            path1.arc(center:Point(x:x, y:y), radius:size, startAngle: -(Double.pi / 2), endAngle: 0)
            
            path2.arc(center:Point(x:x, y:y), radius:size, startAngle:0, endAngle:(Double.pi / 2))
            
            path3.arc(center:Point(x:x, y:y), radius:size, startAngle:(Double.pi / 2), endAngle: Double.pi)
            
            switch sky_cover1 {
            case "SKC":
                canvas.render(circle)
            case "FEW":
                canvas.render(path1, circle) 
                Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y),toppoint:DoublePoint(x:x,y:y-size),rightpoint:DoublePoint(x:x+size,y:y),triangle:path1)
            case "SCT":
                canvas.render(path1, path2, circle)
                Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y),toppoint:DoublePoint(x:x,y:y-size),rightpoint:DoublePoint(x:x+size,y:y),triangle:path1)
                Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y+size),toppoint:DoublePoint(x:x,y:y),rightpoint:DoublePoint(x:x+size,y:y),triangle:path2)
            case "BKN":
                canvas.render(path1, path2, path3, circle)
                Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y),toppoint:DoublePoint(x:x,y:y-size),rightpoint:DoublePoint(x:x+size,y:y),triangle:path1)
                Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x,y:y+size),toppoint:DoublePoint(x:x,y:y),rightpoint:DoublePoint(x:x+size,y:y),triangle:path2)
                Triangle(canvas:canvas,fillStyle:fillStyle,leftpoint:DoublePoint(x:x-size,y:y),toppoint:DoublePoint(x:x,y:y),rightpoint:DoublePoint(x:x,y:y+size),triangle:path3)
            case "OVC":
                canvas.render(fullcircle)
            default:
                canvas.render(circle)
            }
            
            
            let id = (Text(location:Point(x:x + (size * (3/2)), y:y + (size * (3/2))), text:"\(station_id)"))
            id.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), id)
            
            let temp = (Text(location:Point(x:x - (size * (5/2)), y: y - (size * (3/2))), text:"\(temp_c)"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), temp)

            let altimeter = (Text(location:Point(x:x + (size * (3/2)), y: y - (size * (3/2))), text:"\(Int(altim_in_hg))"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), altimeter)

            let dew = (Text(location:Point(x:x - (size * (5/2)), y:y + (size * (3/2))), text:"\(Int(dew_point))"))
            temp.font = "\(size/2)pt Arial"
            canvas.render(FillStyle(color:Color(.black)), dew)

            if visibility != nil {
                let visibilit = (Text(location:Point(x:x - (size * 3), y:y), text:"\(Int(visibility!))"))
                temp.font = "\(size/2)pt Arial"
                canvas.render(FillStyle(color:Color(.black)), visibilit)
            }
            
            if ceiling != nil {
                let ceilin = (Text(location:Point(x:x + (size * 2), y:y), text:"\(Int(ceiling!))"))
                temp.font = "\(size/2)pt Arial"
                canvas.render(FillStyle(color:Color(.black)), ceilin)
            }

            switch precip {
            case "-RA":
                lrain.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(lrain)            
            case "RA":
                mrain.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(mrain)            
            case "%2BRA":
                hrain.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(hrain)            
            case "-SN":
                lsnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(lsnow)            
            case "SN":
                msnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(msnow)            
            case "%2BSN":
                hsnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(hsnow)            
            case "BR":
                mist.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(mist)
            case "-DZ":
                hsnow.renderMode = .destinationRect(Rect(topLeft:Point(x:x - (size * (5/2)), y: y - (size / 2)), size:Size(width:size, height:size)))
                canvas.render(drizzle)
            default:
                do {}
            }
        }  
    }
}
