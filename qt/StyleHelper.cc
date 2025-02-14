// This file Copyright © 2017-2022 Mnemosyne LLC.
// It may be used under GPLv2 (SPDX: GPL-2.0), GPLv3 (SPDX: GPL-3.0),
// or any future license endorsed by Mnemosyne LLC.
// License text can be found in the licenses/ folder.

#include "StyleHelper.h"

QIcon::Mode StyleHelper::getIconMode(QStyle::State state)
{
    if (!state.testFlag(QStyle::State_Enabled))
    {
        return QIcon::Disabled;
    }

    if (state.testFlag(QStyle::State_Selected))
    {
        return QIcon::Selected;
    }

    return QIcon::Normal;
}
