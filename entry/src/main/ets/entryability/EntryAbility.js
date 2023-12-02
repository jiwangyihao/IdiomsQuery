import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import data_preferences from '@ohos.data.preferences';
import http from '@ohos.net.http';
let httpRequest = http.createHttp();
export default class EntryAbility extends UIAbility {
    onCreate(want, launchParam) {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    }
    onDestroy() {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    }
    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
        let preferences = null;
        try {
            data_preferences.getPreferences(this.context, 'QueryHistory', function (err, val) {
                if (err) {
                    console.error("Failed to get data_preferences. code =" + err.code + ", message =" + err.message);
                    return;
                }
                preferences = val;
                console.info("Succeeded in getting preferences.");
            });
            preferences.get('QueryHistory', '[]').then((value) => {
                console.info("Succeeded in getting preferences value = " + value);
                let QueryHistory = [];
                JSON.parse(value).forEach(element => {
                    QueryHistory.push(element);
                });
                AppStorage.SetOrCreate('QueryHistory', QueryHistory);
            }).catch((err) => {
                console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
            });
        }
        catch (err) {
            console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
        }
        windowStage.loadContent('pages/Index', (err, data) => {
            var _a, _b;
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', (_a = JSON.stringify(err)) !== null && _a !== void 0 ? _a : '');
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', (_b = JSON.stringify(data)) !== null && _b !== void 0 ? _b : '');
        });
    }
    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
        const QueryHistory = AppStorage.SetAndLink('QueryHistory', []).get();
        let preferences = null;
        try {
            let promise = data_preferences.getPreferences(this.context, 'mystore');
            promise.then((object) => {
                preferences = object;
                console.info("Succeeded in getting preferences.");
            }).catch((err) => {
                console.error("Failed to get preferences. code =" + err.code + ", message =" + err.message);
            })
            // preferences.put('QueryHistory', JSON.stringify(QueryHistory))
            //     .catch((err) => {
            //         console.error("Failed to put preferences. code =" + err.code + ", message =" + err.message);
            //     });
        } catch(err) {
            console.error("Failed to get a_preferences. code =" + err.code + ", message =" + err.message);
        }
    }
    onForeground() {
        // Ability has brought to foreground
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
    }
    onBackground() {
        // Ability has back to background
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
    }
}
//# sourceMappingURL=EntryAbility.js.map