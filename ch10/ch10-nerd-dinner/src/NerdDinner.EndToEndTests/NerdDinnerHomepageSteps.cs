using NUnit.Framework;
using OpenQA.Selenium;
using SimpleBrowser.WebDriver;
using TechTalk.SpecFlow;

namespace NerdDinner.EndToEndTests
{
    [Binding]
    public class NerdDinnerHomepageSteps
    {
        private static IWebDriver _Driver;

        [BeforeFeature]
        public static void Setup()
        {
            _Driver = new SimpleBrowserDriver();
        }

        [AfterFeature]
        public static void TearDown()
        {
            _Driver.Close();
            _Driver.Dispose();
        }

        [Given(@"I navigate to the app at ""(.*)""")]
        public void GivenINavigateToTheAppAt(string url)
        {
            _Driver.Navigate().GoToUrl(url);
        }
        
        [When(@"I see the homepage")]
        public void WhenISeeTheHomepage()
        {
            Assert.AreEqual("Nerd Dinner - razor", _Driver.Title.Trim());
        }
        
        [Then(@"the heading should contain ""(.*)""")]
        public void ThenTheHeadingShouldContain(string text)
        {
            var h1 = _Driver.FindElement(By.TagName("h1"));
            Assert.IsTrue(h1.Text.Contains(text));
        }
    }
}
