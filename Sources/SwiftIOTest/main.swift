import SwiftIO
import UcglibSwiftIO
import SwiftIOBoard
import CUcglibSwiftIO

let spi = SPI(Id.SPI0)

var ucg = Ucglib_ST7735_18x128x160_HWSPI(spi: spi, cd: Id.D5, cs: Id.D9, reset: Id.D4)

ucg.setColor(r: 255, g: 255, b: 255)

ucg.begin(isTransparent: UInt8(UCG_FONT_MODE_SOLID))
ucg.clearScreen()
ucg.setRotate180()

let firstFontByte = ucg_font_inr21_mr.0

//ucg.setFont(&ucg_font_inr21_mr[0])
withUnsafePointer(to: ucg_font_inr21_mr) { ptr in
    var rawPtr = UnsafeRawBufferPointer(start: ptr, count: Mirror(reflecting: ptr.pointee).children.count)
    
    ucg.setFont(rawPtr.baseAddress!.assumingMemoryBound(to: UInt8.self))
}

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
//ucg.setFont(UnsafePointer(ucg_font_inb16_mr))
