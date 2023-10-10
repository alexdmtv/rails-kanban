import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
    static targets = ['closeBtn']
    static values = {
        open: Boolean
    }

    connect() {
        this.logo_separator = document.querySelector('#topbar_logo_separator')
        this.topbar_logo = document.querySelector('#topbar_logo')
        this.invisible_sidebar_btn = document.querySelector('#invisible_sidebar_btn')
    }

    open() {
        this.element.classList.add('!basis-0')
        this.element.classList.add('!overflow-x-hidden')

        this.topbar_logo.classList.toggle('md:hidden')
        this.logo_separator.classList.replace('md:hidden', 'md:block')
        this.closeBtnTarget.classList.add('!absolute', '!block', '!bottom-0')
        this.invisible_sidebar_btn.classList.replace('hidden', 'flex')

        this.closeBtnTarget.classList.add('!bg-main-purple', 'hover:!bg-main-purple-hover', '!text-white', '!px-5')
        this.closeBtnTarget.querySelector('span').classList.add('!hidden')

        this.openValue = false
    }

    close() {
        this.element.classList.remove('!basis-0')
        setTimeout(() => {
            this.element.classList.remove('!overflow-x-hidden')
        }, 300)

        this.topbar_logo.classList.toggle('md:hidden')
        this.logo_separator.classList.replace('md:block', 'md:hidden')
        this.closeBtnTarget.classList.remove('!absolute', '!block', '!bottom-0')
        this.invisible_sidebar_btn.classList.replace('flex', 'hidden')

        this.closeBtnTarget.classList.remove('!bg-main-purple', 'hover:!bg-main-purple-hover', '!text-white', '!px-5')
        setTimeout(() => {
            this.closeBtnTarget.querySelector('span').classList.remove('!hidden')
        }, 300)
        this.openValue = true
    }

    toggle() {
        if (this.openValue) {
            this.open()
        } else {
            this.close()
        }
    }
}
