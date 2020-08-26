//
//  demoView.swift
//  PageViewExample
//
//  Created by Shunzhe Ma on 8/26/20.
//

import SwiftUI

struct textOnlyView: View {
    
    var contentText: String
    
    var body: some View {
        Text(contentText)
            .font(.largeTitle)
    }
    
}

struct demoView_Previews: PreviewProvider {
    static var previews: some View {
        textOnlyView(contentText: "Hello, world!")
    }
}
