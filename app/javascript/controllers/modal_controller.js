import {Controller} from "@hotwired/stimulus"
import {toggle, enter, leave} from 'el-transition'

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ['backdrop', 'dialogPanel']

    connect() {
        document.addEventListener('keydown', this.handleKeydown)
        document.addEventListener('click', this.handleCloseClick)
        this.open()
    }

    disconnect() {
        document.removeEventListener('keydown', this.handleKeydown)
        document.removeEventListener('click', this.handleCloseClick)
    }

    handleKeydown = (e) => {
        if (e.key === 'Escape') {
            this.close()
        }
    }

    handleCloseClick = (e) => {
        if (!this.dialogPanelTarget.contains(e.target)) {
            this.close()
        }
    }

    close = async (e) => {
        e?.preventDefault()
        // this.element.classList.add('hidden')
        leave(this.backdropTarget)
        await leave(this.dialogPanelTarget)
        this.element.classList.add('hidden')
    }

    open = async (e) => {
        e?.preventDefault()
        // this.element.classList.remove('hidden')
        enter(this.backdropTarget)
        enter(this.dialogPanelTarget)
    }

}
