import Scenes
import Igis
import Foundation
/*
 This class is responsible for the background Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class Background : RenderableEntity {
    let map : Image
   // var didDraw = false
    
    init() {
        guard let mapURL = URL(string:"https://media2.houstonpress.com/hou/imager/u/magnum/10633390/google-map-privacy.jpg?cb=1639707463") else {
            fatalError("NO MAP")
        }
         
        map = Image(sourceURL:mapURL)
             
        
        super.init(name:"Background")
        // We insert our RenderableEntities in the constructor
        //          insert(entity:background, at:.back)

    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(map)
    }
    override func render(canvas:Canvas) {
        var count = 0.0
        if let canvasSize = canvas.canvasSize {
            if map.isReady {
                map.renderMode = .destinationRect(Rect(topLeft:Point(), size:canvasSize))
                canvas.render(map)
 //               didDraw = true
            }
        }
    }
}
