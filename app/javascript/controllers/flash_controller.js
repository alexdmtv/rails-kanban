import {Controller} from '@hotwired/stimulus';
import {enter, leave} from 'el-transition';

export default class extends Controller {
    connect() {
        enter(this.element).then(() => {
            this.timer = setTimeout(() => {
                this.dismiss();
            }, 3000);
        });

        this.element.addEventListener('mouseenter', this.pauseTimer.bind(this));
        this.element.addEventListener('mouseleave', this.resumeTimer.bind(this));
    }

    disconnect() {
        this.element.removeEventListener('mouseenter', this.pauseTimer.bind(this));
        this.element.removeEventListener('mouseleave', this.resumeTimer.bind(this));
    }

    pauseTimer() {
        clearTimeout(this.timer);
    };

    resumeTimer() {
        this.timer = setTimeout(() => {
            this.dismiss();
        }, 3000);
    };

    dismiss() {
        leave(this.element).then(() => {
            this.element.remove();
        });
    };
}
