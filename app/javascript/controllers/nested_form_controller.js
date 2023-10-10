import {Controller} from "@hotwired/stimulus"
import {enter, leave} from 'el-transition'

// Connects to data-controller="nested-form"
export default class extends Controller {
    static targets = ['addBtn', 'item', 'template']

    connect() {
        this.element.addEventListener('keydown', this.handleKeydown)
    }

    disconnect() {
        this.element.removeEventListener('keydown', this.handleKeydown)
    }

    handleKeydown = (event) => {
        if (event.key === 'Enter' && event.target.matches('input[type="text"], select')) {
            event.preventDefault()
        }

        if (event.key === 'Enter' && event.target.closest('div[data-nested-form-target=item]')) {
            this.addItem(event)
        }
    }

    addItem = (event) => {
        event.preventDefault()

        let content = this.getTemplateItem()
        let new_item = this.addBtnTarget.parentElement.insertBefore(content, this.addBtnTarget)

        // find input inside new item and focus on it
        let input = new_item.querySelector('input')
        if (input) {
            input.focus()
        }
    }

    removeItem = (event) => {
        event.preventDefault()
        event.stopPropagation();

        let item = event.target.closest('div[data-nested-form-target=item]')

        if (event.params.newRecord) {
            item.remove()
            return
        }

        item.querySelector("input[name*='_destroy']").value = 1
        item.style.display = 'none'
    }

    getTemplateItem = () => {
        let templateHTML = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().valueOf());
        let templateCopy = document.createElement('template');
        templateCopy.innerHTML = templateHTML;

        return templateCopy.content.children[0]
    }
}
