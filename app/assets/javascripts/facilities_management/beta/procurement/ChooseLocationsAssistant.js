$(function () {
    if ($('.chooser-component').length > 0) {
        try {
            let activeChooser = null;
            activeChooser = initialiseChooseLocations();

            if (null !== activeChooser) {
                activeChooser.init();
                activeChooser.PrimeBasket();
            }
        } catch (e) {
            console.log("No location chooser component found");
        }
    }
    function initialiseChooseLocations() {
        let obj = new ChooserComponent("procurement", "locations", pageUtils.getCachedData('fm-locations'));
        if (obj.validate()) {
            return obj;
        } else {
            return null;
        }
    }
});
