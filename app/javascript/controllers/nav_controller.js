import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menuButton", "menu"]

  initialize() {
    this.highlightActiveLink()
  }

  highlightActiveLink() {
    // get all the nav links
    const links = this.element.querySelectorAll("a")

    // get the current URL
    const currentUrl = window.location.href

    // loop through the links
    links.forEach(link => {
      // if the link's href matches the current URL, add the "bg-gray-900 text-white" class
      // otherwise, remove it
      if (link.href === currentUrl) {
        link.classList.add("bg-gray-900", "text-white")
      } else {
        link.classList.remove("bg-gray-900", "text-white")
      }
    })
  }

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
    this.menuButtonTarget.setAttribute("aria-expanded", !this.menuTarget.classList.contains("hidden"))
  }
}

