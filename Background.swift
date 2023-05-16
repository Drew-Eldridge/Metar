import Foundation
import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */

class Background : RenderableEntity {
    let map : Image
    
    
    init() {
/*        guard let mapURL = URL(string:"USmap.png") else {
            fatalError("Failed to create URL for map")
            }
 */
            
 
        guard let mapURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/a/a4/Map_of_USA_with_state_and_territory_names_2.png") else {
            fatalError("Failed to create URL for map")
        }
        
 
        map = Image(sourceURL:mapURL)
          
        // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(map)
    }
    override func render(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize{
            if map.isReady {
                map.renderMode = .destinationRect(Rect(topLeft:Point(), size:canvasSize))
                canvas.render(map)
            }
        }
    }
}
