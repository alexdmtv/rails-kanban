import {Controller} from "@hotwired/stimulus"
import {toggle} from 'el-transition'

// Connects to data-controller="dots-menu"
export default class extends Controller {
    static targets = ["button", "content", "linksContainer"]

    connect() {
        document.addEventListener('click', this.handleOuterClick.bind(this))

        // Close the popup after clicking an internal link.
        const links = Array.from(this.linksContainerTarget.querySelectorAll('a'))
        links.forEach((l) => l.dataset.action = "click -> dots-menu#handleToggle")
    }

    disconnect() {
        document.removeEventListener('click', this.handleOuterClick.bind(this))
    }

    handleToggle(e) {
        toggle(this.contentTarget)
    }

    handleOuterClick(e) {
        if (!this.element.contains(e.target) && !this.contentTarget.classList.contains('hidden')) {
            this.handleToggle()
        }
    }

}
