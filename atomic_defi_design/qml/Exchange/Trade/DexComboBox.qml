import QtQuick 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.0
import QtQuick.Controls.Universal 2.12

import "../../Components"
import "../../Constants"

DefaultComboBox {
    id: control

    mainBorderColor: Style.getCoinColor(ticker)

    contentItem: DexComboBoxLine {
        id: line
        padding: 10

        Component.onCompleted: API.app.portfolio_pg.portfolio_mdl.portfolioItemDataChanged.connect(forceUpdateDetails)

        function forceUpdateDetails() {
            console.log("Portfolio item data changed, force-updating the selected ticker details!")
            ++update_count
        }

        property int update_count: 0

        details: ({
            update_count:           line.update_count,
            ticker:                 model.data(model.index(combo.currentIndex, 0), 257),
            name:                   model.data(model.index(combo.currentIndex, 0), 258),
            balance:                model.data(model.index(combo.currentIndex, 0), 259),
            main_currency_balance:  model.data(model.index(combo.currentIndex, 0), 260)
        })
    }

    // Each dropdown item
    delegate: ItemDelegate {
        Universal.accent: control.lineHoverColor
        width: control.width
        highlighted: control.highlightedIndex === index


        contentItem: DexComboBoxLine {
            details: model
        }
    }
}
