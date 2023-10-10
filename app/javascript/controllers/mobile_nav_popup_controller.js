import {Controller} from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'

// Connects to data-controller="mobile-nav-popup"
export default class extends Controller {
    static targets = ['backdrop', 'modalPane']

    connect() {
        this.setBtnListener()
        document.addEventListener('click', this.handleCloseClick)
    }

    disconnect() {
        super.disconnect();
        this.btn.removeEventListener('click', this.handleToggle)
        document.removeEventListener('click', this.handleCloseClick)
    }

    setBtnListener() {
        this.btn = document.getElementById('mobile_nav_popup_btn')
        if (this.btn) {
            this.btn.addEventListener('click', this.handleToggle)
        }
    }

    handleToggle = () => {
        toggle(this.element)
        toggle(this.backdropTarget)
        toggle(this.modalPaneTarget)
        this.changeIcon()
    }

    changeIcon() {
        let down_icon = document.getElementById('icon_chevron_down')
        let up_icon = document.getElementById('icon_chevron_up')

        down_icon.classList.toggle('hidden')
        up_icon.classList.toggle('hidden')
    }

    handleCloseClick = async (e) => {
        if (!this.modalPaneTarget.contains(e.target)
            && !this.btn.contains(e.target)
            && !this.element.classList.contains('hidden')) {
            this.handleToggle()
        }
    }
}
