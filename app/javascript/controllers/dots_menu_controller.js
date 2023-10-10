import {Controller} from "@hotwired/stimulus"
import {toggle} from 'el-transition'

// Connects to data-controller="dots-menu"
export default class extends Controller {
    static targets = ["button", "content"]

    connect() {
        document.addEventListener('click', this.handleCloseClick)
    }

    disconnect() {
        super.disconnect();
    }

    handleToggle = (e) => {
        toggle(this.contentTarget)
    }

    handleCloseClick = (e) => {
        if (!this.element.contains(e.target) && !this.contentTarget.classList.contains('hidden')) {
            this.handleToggle()
        }
    }

}
