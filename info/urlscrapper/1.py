import requests
from bs4 import BeautifulSoup

def web_scraper(url):
    try:
        # Send a GET request to the URL
        response = requests.get(url)

        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            # Parse the HTML content of the page
            soup = BeautifulSoup(response.text, 'html.parser')

            # Extract relevant information based on the webpage structure
            # For example, extracting all the links on the page
            links = soup.find_all('a')

            # Print the extracted links
            print("Extracted Links:")
            for link in links:
                print(link.get('href'))

            # Save the extracted information to a file (you can customize this part)
            with open('web_scraper_output.txt', 'w') as file:
                file.write("Extracted Links:\n")
                for link in links:
                    file.write(link.get('href') + '\n')

            print("Web scraping completed. Output saved to web_scraper_output.txt")
        else:
            print(f"Error: Unable to fetch content. Status code: {response.status_code}")

    except Exception as e:
        print(f"An error occurred: {e}")

# Main script
if __name__ == "__main__":
    print("Enter the URL for web scraping:")
    target_url = input()
    web_scraper(target_url)
