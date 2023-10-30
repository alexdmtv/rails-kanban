import {Controller} from "@hotwired/stimulus"
import {toggle} from 'el-transition'

// Connects to data-controller="theme-switcher"
export default class extends Controller {
    static targets = ['icon']

    initialize() {
        this.initTheme()
    }

    toggleTheme() {
        if (localStorage.theme === 'light') {
            this.setDarkTheme()
        } else {
            this.setLightTheme()
        }
    }

    setDarkTheme() {
        localStorage.theme = 'dark'
        document.documentElement.classList.add('dark')
        this.element.classList.replace('bg-main-purple', 'bg-dark-grey')
        this.iconTarget.classList.replace('translate-x-0', 'translate-x-5')
    }

    setLightTheme() {
        localStorage.theme = 'light'
        document.documentElement.classList.remove('dark')
        this.element.classList.replace('bg-dark-grey', 'bg-main-purple')
        this.iconTarget.classList.replace('translate-x-5', 'translate-x-0')
    }

    initTheme() {
        if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            this.setDarkTheme()
        } else {
            localStorage.theme = 'light'
        }
    }


}
