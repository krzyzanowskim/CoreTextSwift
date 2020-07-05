//
//  File.swift
//  
//
//  Created by Marcin Krzyzanowski on 05/07/2020.
//

import CoreText
import Foundation

public enum FontManager {

  /// A comparator function to compare font family names and sort them according to Apple guidelines.
  public static func availableFontFamilyNames() -> [String] {
    CTFontManagerCopyAvailableFontFamilyNames() as? [String] ?? []
  }

  #if os(OSX)
  /// Returns an array of font URLs.
  @available(OSX 10.6, *)
  public static func availableFontURLs() -> [URL] {
    CTFontManagerCopyAvailableFontURLs() as? [URL] ?? []
  }
  #endif

  /// Returns an array of unique PostScript font names for the fonts.
  public static func availablePostScriptNames() -> [String] {
    CTFontManagerCopyAvailablePostScriptNames() as? [String] ?? []
  }

  /// Creates a font descriptor representing the font in the supplied data.
  public static func fontDescriptor(from data: Data) -> CTFontDescriptor? {
    CTFontManagerCreateFontDescriptorFromData(data as CFData)
  }

  /// Returns an array of font descriptors representing each of the fonts in the specified URL.
  public static func fontDescriptors(from fileURL: URL) -> [CTFontDescriptor] {
    CTFontManagerCreateFontDescriptorsFromURL(fileURL as CFURL) as? [CTFontDescriptor] ?? []
  }

  /// Registers fonts from the specified font URL with the Font Manager. Registered fonts are discoverable through font descriptor matching.
  /// - Parameters:
  ///   - fontURL: The font URL.
  ///   - scope: Scope constant defining the availability and lifetime of the registration. See CTFontManagerScope for values to pass for this parameter.
  /// - Throws: An error in case of failed registration
  public static func registerFont(fontURL: URL, scope: CTFontManagerScope = .user) throws {
    guard let error = CFErrorCreate(nil, kCFErrorDomainPOSIX, 0, nil) else {
      return
    }

    var unmanagedError: Unmanaged<CFError>? = Unmanaged.passRetained(error)
    CTFontManagerRegisterFontsForURL(fontURL as CFURL, scope, &unmanagedError)
    if let error = unmanagedError {
      throw error.takeRetainedValue()
    }
  }

  /// Unregisters fonts from the specified font URL with the Font Manager. Unregistered fonts are no longer discoverable through font descriptor matching.
  public static func unregisterFonts(fontURL: URL, scope: CTFontManagerScope = .user) throws {
    guard let error = CFErrorCreate(nil, kCFErrorDomainPOSIX, 0, nil) else {
      return
    }
    var unmanagedError: Unmanaged<CFError>? = Unmanaged.passRetained(error)
    CTFontManagerUnregisterFontsForURL(fontURL as CFURL, scope, &unmanagedError)
    if let error = unmanagedError {
      throw error.takeRetainedValue()
    }
  }
}
