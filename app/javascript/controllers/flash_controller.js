import {Controller} from "@hotwired/stimulus"
import {enter, leave} from 'el-transition'

export default class extends Controller {
    connect() {
        enter(this.element)
            .then(() => {
                setTimeout(() => {
                    this.dismiss()
                }, 1000)
            })
    }

    dismiss = () => {
        leave(this.element)
            .then(() => {
                this.element.remove()
            })
    }
}
