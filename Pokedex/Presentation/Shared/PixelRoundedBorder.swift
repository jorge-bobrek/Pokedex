//
//  PixelArtRoundedRectangle.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 12/02/25.
//

import SwiftUI

struct PixelRoundedBorder: Shape {
    var cornerRadius: CGFloat
    var pixelSize: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(cornerRadius, min(rect.width / 2, rect.height / 2))
        
        // Función para dibujar una esquina redondeada
        func drawPixelCorner(center: CGPoint, dx: CGFloat, dy: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = radius
            var d: CGFloat = 3 - 2 * radius
            
            while y >= x {
                if d > 0 {
                    y -= 1
                    d += 4 * (x - y) + 10
                } else {
                    d += 4 * x + 6
                }
                x += 1
                
                // Calcular puntos ajustados para evitar salir del rectángulo
                let point1 = CGPoint(
                    x: center.x + dx * (x - pixelSize),
                    y: center.y + dy * (y - pixelSize)
                )
                let point2 = CGPoint(
                    x: center.x + dx * (y - pixelSize),
                    y: center.y + dy * (x - pixelSize)
                )
                
                // Añadir píxeles si están dentro del rectángulo
                [point1, point2].forEach { point in
                    if rect.contains(point) {
                        path.addRect(CGRect(
                            x: point.x,
                            y: point.y,
                            width: pixelSize,
                            height: pixelSize
                        ))
                    }
                }
            }
        }
        
        // Centros de las esquinas ajustados para incluir el pixelSize
        let topLeftCenter = CGPoint(
            x: rect.minX + radius - pixelSize,
            y: rect.minY + radius - pixelSize
        )
        let topRightCenter = CGPoint(
            x: rect.maxX - radius,
            y: rect.minY + radius - pixelSize
        )
        let bottomLeftCenter = CGPoint(
            x: rect.minX + radius - pixelSize,
            y: rect.maxY - radius
        )
        let bottomRightCenter = CGPoint(
            x: rect.maxX - radius,
            y: rect.maxY - radius
        )
        
        // Dibujar las 4 esquinas
        drawPixelCorner(center: topLeftCenter, dx: -1, dy: -1)
        drawPixelCorner(center: topRightCenter, dx: 1, dy: -1)
        drawPixelCorner(center: bottomLeftCenter, dx: -1, dy: 1)
        drawPixelCorner(center: bottomRightCenter, dx: 1, dy: 1)
        
        // Dibujar bordes rectos
        // Borde superior
        stride(
            from: rect.minX + radius,
            to: rect.maxX - radius,
            by: pixelSize
        ).forEach { x in
            path.addRect(CGRect(
                x: x,
                y: rect.minY,
                width: pixelSize,
                height: pixelSize
            ))
        }
        
        // Borde inferior
        stride(
            from: rect.minX + radius,
            to: rect.maxX - radius,
            by: pixelSize
        ).forEach { x in
            path.addRect(CGRect(
                x: x,
                y: rect.maxY - pixelSize,
                width: pixelSize,
                height: pixelSize
            ))
        }
        
        // Borde izquierdo
        stride(
            from: rect.minY + pixelSize + radius,
            to: rect.maxY + 1 - radius,
            by: pixelSize
        ).forEach { y in
            path.addRect(CGRect(
                x: rect.minX,
                y: y - pixelSize,
                width: pixelSize,
                height: pixelSize
            ))
        }
        
        // Borde derecho
        stride(
            from: rect.minY + pixelSize + radius,
            to: rect.maxY + 1 - radius,
            by: pixelSize
        ).forEach { y in
            path.addRect(CGRect(
                x: rect.maxX - pixelSize,
                y: y - pixelSize,
                width: pixelSize,
                height: pixelSize
            ))
        }
        
        return path
    }
}

extension View {
    func pixelRoundedBorder(
        cornerRadius: CGFloat,
        pixelSize: CGFloat = 1,
        borderColor: Color = .secondary,
        fillColor: Color? = nil
    ) -> some View {
        self.background(
            Group {
                if let fillColor = fillColor {
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .fill(fillColor)
                }
            }
        )
        .overlay(
            PixelRoundedBorder(
                cornerRadius: cornerRadius,
                pixelSize: pixelSize
            )
            .fill(borderColor)
            .padding(-1)
        )
    }
}

/*
struct ContentView: View {
    var body: some View {
        Text("Pixel Art Border")
            .padding()
            .pixelRoundedBorder(
                cornerRadius: 16,
                pixelSize: 1,
                borderColor: .black,
                fillColor: .yellow
            )
            .padding()
    }
}

struct preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
