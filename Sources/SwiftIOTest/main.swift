import SwiftIO
import UcglibSwiftIO
import CUcglibSwiftIO
import MadBoard

extension String {
	func leftPadding(toLength: Int, withPad character: Character) -> String {
		let stringLength = self.count
		if stringLength < toLength {
			return String(repeatElement(character, count: toLength - stringLength)) + self
		} else {
			return String(self.suffix(toLength))
		}
	}
}

let spi = SPI(Id.SPI0, speed: 14000000)

var ucg = Ucglib_ST7735_18x128x160_HWSPI(spi: spi, cd: Id.D5, cs: Id.D9, reset: Id.D4)

ucg.setColor(r: 255, g: 255, b: 255)

ucg.begin(isTransparent: UInt8(UCG_FONT_MODE_SOLID))
ucg.clearScreen()
ucg.setRotate180()

//ucg.setFont(&ucg_font_inr21_mr[0])
/*withUnsafePointer(to: ucg_font_inb16_mr) { ptr in
    let rawPtr = UnsafeRawBufferPointer(start: ptr, count: Mirror(reflecting: ptr.pointee).children.count)
    
    ucg.setFont(rawPtr.baseAddress!.assumingMemoryBound(to: UInt8.self))
}*/

ucg.setFont("JetBrainsMono")

ucg.setColor(r: 255, g: 255, b: 255)
ucg.setColor(idx: 1, r: 0, g: 0, b: 0)
ucg.setPrintPos(x: 0, y: 24)
ucg.print("Hello")

ucg.setColor(r: 255, g: 0, b: 0)
ucg.setPrintPos(x: 0, y: 50)
ucg.print("World!")

ucg.setColor(r: 0, g: 255, b: 255)
ucg.drawFrame(x: 0, y: 58, w: 60, h: 30)

ucg.setColor(r: 0, g: 255, b: 255)
ucg.drawRFrame(x: 68, y: 58, w: 59, h: 30, r: 8)

ucg.setColor(r: 255, g: 0, b: 0)
ucg.drawDisc(x0: 22, y0: 106, rad: 16, option: UInt8(UCG_DRAW_UPPER_RIGHT | UCG_DRAW_UPPER_LEFT | UCG_DRAW_LOWER_RIGHT | UCG_DRAW_LOWER_LEFT))

ucg.setColor(r: 128, g: 0, b: 128)
ucg.drawBox(x: 50, y: 92, w: 70, h: 31)

ucg.setColor(r: 255, g: 255, b: 255)
ucg.drawHLine(x: 0, y: 126, len: 128)

ucg.setColor(r: 0, g: 255, b: 0)
ucg.drawRBox(x: 2, y: 132, w: 45, h: 25, r: 8)

ucg.setColor(r: 255, g: 255, b: 0)
ucg.drawCircle(x0: 110, y0: 144, rad: 14, option: UInt8(UCG_DRAW_UPPER_RIGHT | UCG_DRAW_UPPER_LEFT | UCG_DRAW_LOWER_RIGHT | UCG_DRAW_LOWER_LEFT))

ucg.setColor(r: 0, g: 0, b: 255)
ucg.drawTriangle(x0: 50, y0: 159, x1: 70, y1: 130, x2: 90, y2: 159)

var Variable1 = 0

while true {
	Variable1 += 1
	
	if Variable1 > 150 {
		Variable1 = 0
	}
	
	let paddedString = String(Variable1).leftPadding(toLength: 3, withPad: " ")
	
	/*withUnsafePointer(to: ucg_font_inb16_mr) { ptr in
		let rawPtr = UnsafeRawBufferPointer(start: ptr, count: Mirror(reflecting: ptr.pointee).children.count)
		
		ucg.setFont(rawPtr.baseAddress!.assumingMemoryBound(to: UInt8.self))
	}*/
	
	ucg.setFont("inb16_mr")
	
	ucg.setColor(r: 255, g: 255, b: 0)
	ucg.setColor(idx: 1, r: 0, g: 0, b: 0)
	ucg.setPrintPos(x: 9, y: 81)
	ucg.print(String(Variable1))
	
	if Variable1 < 10 {
		ucg.print(" ")
	}
	
	if Variable1 < 100 {
		ucg.print(" ")
	}
	
	/*withUnsafePointer(to: ucg_font_inb16_mr) { ptr in
		let rawPtr = UnsafeRawBufferPointer(start: ptr, count: Mirror(reflecting: ptr.pointee).children.count)
		
		ucg.setFont(rawPtr.baseAddress!.assumingMemoryBound(to: UInt8.self))
	}*/
	
	ucg.setColor(r: 0, g: 255, b: 0)
	ucg.setColor(idx: 1, r: 0, g: 0, b: 0)
	ucg.setPrintPos(x: 76, y: 81)
	ucg.print(paddedString)
}
