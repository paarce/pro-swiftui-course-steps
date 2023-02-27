//
//  SwiftUIView44.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 23/2/23.
//

import SwiftUI

struct RelativeHStack: Layout {

    var spacing = 0.0

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let frames = frame(for: subviews, in: width)
        let lowestView = frames.max { $0.maxY < $1.maxY } ?? .zero
        return CGSize(width: width, height: lowestView.maxY)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frame(for: subviews, in: bounds.width)

        for index in subviews.indices {
            let frame = viewFrames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.midY)
            subviews[index].place(at: position, anchor: .leading, proposal: ProposedViewSize(frame.size))
        }
    }

    func frame(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {

        let totalSpacing = spacing * Double(subviews.count - 1)
        let availableWidth = totalWidth - totalSpacing
        let totalProrities = subviews.reduce(0) { $0 + $1.priority }

        var viewFrames = [CGRect]()
        var x = 0.0

        for subview in subviews {
            let subviewWidth = availableWidth * subview.priority / totalProrities
            let proposal = ProposedViewSize(width: subviewWidth, height: nil)
            let size = subview.sizeThatFits(proposal)

            let frame = CGRect(x: x, y: 0, width: size.width, height: size.height)
            viewFrames.append(frame)

            x += size.width + spacing
        }

        return viewFrames
    }
}

struct SwiftUIView44: View {
    var body: some View {
        RelativeHStack(spacing: 50) {
            Text("Hello, World!")
                .frame(maxWidth: .infinity)
                .background(.red)
                .layoutPriority(1)

            Text("Second")
                .frame(maxWidth: .infinity)
                .background(.green)
                .layoutPriority(2)

            Text("Third")
                .frame(maxWidth: .infinity)
                .background(.blue)
                .layoutPriority(3)
        }
    }
}

struct SwiftUIView44_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView44()
    }
}

//{
//    "version":"2.2.2",
//    "fuc":"358208445",
//    "bundle":"com.clickrent",
//    "parametros":
//    {
//        "Ds_Merchant_PayMethods":"T",
//        "Ds_Merchant_Order":"3010620",
//        "Ds_Merchant_Identifier":"",
//        "Ds_Merchant_Module":"PSis_IOS",
//        "Ds_Merchant_MerchantName":"ClickRent",
//        "Ds_Merchant_Currency":"978",
//        "Ds_Merchant_Group":"",
//        "Ds_Merchant_TransactionType":"1",
//        "Ds_Merchant_ConsumerLanguage":"",
//        "Ds_Merchant_Terminal":"1",
//        "Ds_Merchant_UrlKO":"REDIR_URL_KO",
//        "Ds_Merchant_MerchantURL":"",
//        "Ds_Merchant_UrlOK":"REDIR_URL_OK",
//        "Ds_merchant_MerchantDescriptor":"",
//        "Ds_Merchant_Amount":"3000",
//        "Ds_Merchant_DirectPayment":"false",
//        "Ds_Merchant_ProductDescription":"Car black",
//        "Ds_Merchant_MerchantData":"",
//        "Ds_Merchant_MerchantCode":"358208445",
//        "Ds_Merchant_Titular":""
//    },
//    "so":"ios",
//    "terminal":"1"
//}

//[
//    "DS_XPAYDATA":"7ba9992264617461223a22435a4f4f5062692f5237554264573361733754202630595957755131695a6876746a4166782b413d3d222ca999227369676e6174757265223a224d4941474353714753496233445145484171434120263367417463447766645a4941414141414141413d222ca99922686561646572223a7ba9999227075626c69634b657948617368223a2269344273503368374164614d33445533305541327075634c63505954314a3962416a3367693865414f7a773d222ca999922657068656d6572616c5075626c69634b6579223a224d466b77457759484b6f5a497a6a30434151594920264f79487079566e526f642b437042544d78513d3d222ca9999227472616e73616374696f6e4964223a226139626638653731636135383137336434326166356632346235376365303437353238666232383537353962323936633132663364386632653539323636343422a9997d2ca9992276657273696f6e223a2245435f763122a997d",
//    "DS_XPAYTYPE":"Apple",
//    "DS_XPAYORIGEN":"InApp"
//]
