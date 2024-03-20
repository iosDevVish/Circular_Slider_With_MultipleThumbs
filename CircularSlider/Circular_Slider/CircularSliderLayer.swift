import UIKit

class CircularSliderLayer: CALayer {

    var minimumValue: Float = 0
    var maximumValue: Float = 24
    var currentValues: [Float] = [12, 6, 18, 3, 21]
    var isTracking = false

    var thumbRadius: CGFloat = 20
    var circleRadius: CGFloat = 100
    var thumbImages: [UIImage] = [UIImage(named: "A")!, UIImage(named: "B")!, UIImage(named: "C")!, UIImage(named: "D")!, UIImage(named: "E")!]
    //var initialThumbAngles: [Int: CGFloat] = [:]
    var initialThumbAngles: [CGFloat] = []
    var draggedThumbIndex: Int?
    // Property to keep track of the active thumb during interaction
    var activeThumbIndex: Int?

    override func draw(in ctx: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        // Draw circle
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.addPath(circlePath.cgPath)
        ctx.fillPath()

        // Draw thumbs
        for (index, value) in currentValues.enumerated() {
            let thumbAngle = angleForValue(value: value)
            let thumbCenter = pointOnCircle(angle: thumbAngle, radius: circleRadius)

            let thumbRect = CGRect(x: thumbCenter.x - thumbRadius, y: thumbCenter.y - thumbRadius, width: 2 * thumbRadius, height: 2 * thumbRadius)

            if index < thumbImages.count {
                let thumbImage = thumbImages[index]
                ctx.draw(thumbImage.cgImage!, in: thumbRect)
            } else {
                // Draw a default thumb if no image is provided
                let thumbPath = UIBezierPath(ovalIn: thumbRect)
                ctx.setFillColor(UIColor.blue.cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }
    }

    // Touch handling
    // Touch handling
    func handleTouch(at point: CGPoint) {
           for (index, value) in currentValues.enumerated() {
               let thumbAngle = angleForValue(value: value)
               let thumbCenter = pointOnCircle(angle: thumbAngle, radius: circleRadius)
               let thumbRect = CGRect(x: thumbCenter.x - thumbRadius, y: thumbCenter.y - thumbRadius, width: 2 * thumbRadius, height: 2 * thumbRadius)

               if thumbRect.contains(point) {
                   draggedThumbIndex = index

                   // Ensure that initialThumbAngles has enough elements
                   while initialThumbAngles.count <= draggedThumbIndex! {
                       initialThumbAngles.append(0.0)
                   }

                   initialThumbAngles[draggedThumbIndex!] = thumbAngle
                   break
               }
           }
       }


    func valueForAngle(angle: CGFloat) -> Float {
            let valueRange = maximumValue - minimumValue
            let normalizedAngle = angle.truncatingRemainder(dividingBy: 2 * CGFloat(Double.pi))
            let normalizedValue = Float(normalizedAngle / (2 * CGFloat(Double.pi)))
            return minimumValue + normalizedValue * valueRange
        }
    

    func handleDrag(at point: CGPoint) {
        guard let draggedThumbIndex = draggedThumbIndex else { return }

        if initialThumbAngles.isEmpty {
            // Store the initial angles only once when dragging starts
            initialThumbAngles = currentValues.map { value in
                let angle = angleForValue(value: value)
                return angle
            }
        }

        // Ensure that initialThumbAngles has enough elements
        while initialThumbAngles.count < currentValues.count {
            initialThumbAngles.append(0.0)
        }

        let initialAngle = initialThumbAngles[draggedThumbIndex]
        let angle = atan2(point.y - bounds.midY, point.x - bounds.midX)
        let angleChange = angle - initialAngle

        print("Angle Change for Thumb \(draggedThumbIndex + 1): \(angleChange)")

        let currentValue = currentValues[draggedThumbIndex]
        let newValue = valueForAngle(angle: angle)
        let valueChange = newValue - currentValue

        currentValues[draggedThumbIndex] += valueChange
        setNeedsDisplay()

        let clockTime = convertAngleToClockTime(angle: angle)
        print("Clock Time for Thumb \(draggedThumbIndex + 1): \(clockTime)")
    }



    func convertAngleToClockTime(angle: CGFloat) -> String {
        let totalHours = 12
        let degreesPerHour: CGFloat = 360 / CGFloat(totalHours)
        
        // Calculate the hour based on the angle
        var hour = Int(angle / degreesPerHour) + 1
        
        // Adjust the hour to be in the range [1, 12]
        if hour == 0 {
            hour = totalHours
        }
        
        // Convert to 12-hour format
        if hour > totalHours {
            hour -= totalHours
        }
        
        return "\(hour)"
    }




    func endDrag() {
        draggedThumbIndex = nil
        initialThumbAngles.removeAll()
    }


    // Helper methods
    func isPointInsideThumb(point: CGPoint) -> Bool {
        for (index, value) in currentValues.enumerated() {
            let thumbAngle = angleForValue(value: value)
            let thumbCenter = pointOnCircle(angle: thumbAngle, radius: circleRadius)
            let thumbRect = CGRect(x: thumbCenter.x - thumbRadius, y: thumbCenter.y - thumbRadius, width: 2 * thumbRadius, height: 2 * thumbRadius)
            if thumbRect.contains(point) {
                return true
            }
        }
        return false
    }

     func angleForValue(value: Float) -> CGFloat {
        let valueRange = CGFloat(maximumValue - minimumValue)
        let normalizedValue = CGFloat(value - minimumValue) / valueRange
        return normalizedValue * CGFloat(2 * Double.pi)
    }

     func pointOnCircle(angle: CGFloat, radius: CGFloat) -> CGPoint {
        let x = bounds.midX + radius * cos(angle)
        let y = bounds.midY + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
}
