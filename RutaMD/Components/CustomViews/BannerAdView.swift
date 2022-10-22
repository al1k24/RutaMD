//
//  BannerAdView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 26.08.2022.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    var unitID: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        let adView = GADBannerView(adSize: GADAdSizeBanner)
        
        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getRootViewController()
        adView.delegate = context.coordinator
        adView.load(GADRequest())
        
        return adView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
    
    final class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            DEBUG("bannerViewDidReceiveAd")
            
            bannerView.alpha = 0
              UIView.animate(withDuration: 1, animations: {
                bannerView.alpha = 1
              })
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            DEBUG("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            DEBUG("bannerViewDidRecordImpression")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            DEBUG("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            DEBUG("bannerViewWillDIsmissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            DEBUG("bannerViewDidDismissScreen")
        }
    }
}
