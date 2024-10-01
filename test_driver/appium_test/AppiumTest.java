import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.remote.MobileCapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.net.MalformedURLException;
import java.net.URL;

import static org.testng.Assert.assertTrue;

public class AppiumTest {
    private AndroidDriver<MobileElement> driver;

    @BeforeClass
    public void setUp() throws MalformedURLException {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
        caps.setCapability(MobileCapabilityType.DEVICE_NAME, "Android Emulator");
        caps.setCapability(MobileCapabilityType.APP, "build/app/outputs/apk/debug/app-debug.apk");

        driver = new AndroidDriver<>(new URL("http://localhost:4723/wd/hub"), caps);
    }

    @Test
    public void testAppLaunchesAndDisplaysHomeScreen() {
        MobileElement homeScreenElement = driver.findElementByAccessibilityId("home_screen");
        assertTrue(homeScreenElement.isDisplayed());
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}