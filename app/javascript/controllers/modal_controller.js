import {Controller} from '@hotwired/stimulus';
import {enter, leave} from 'el-transition';

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ['backdrop', 'dialogPanel', 'closeBtn'];

    connect() {
        document.addEventListener('keydown', this.handleKeydown.bind(this));
        document.addEventListener('click', this.handleCloseClick.bind(this));
        this.open();
    }

    disconnect() {
        document.removeEventListener('keydown', this.handleKeydown.bind(this));
        document.removeEventListener('click', this.handleCloseClick.bind(this));
    }

    handleKeydown(e) {
        if (e.key === 'Escape') {
            this.close();
        }
    };

    handleCloseClick(e) {
        if (!this.dialogPanelTarget.contains(e.target)) {
            this.close();
        }
    };

    async close(e) {
        e?.preventDefault();
        // this.element.classList.add('hidden')
        leave(this.backdropTarget);
        await leave(this.dialogPanelTarget);

        // make task query param empty
        const url = new URL(window.location.href);
        url.searchParams.delete('task');
        window.history.replaceState({}, '', url);

        this.element.remove();
    };

    async open(e) {
        e?.preventDefault();
        // this.element.classList.remove('hidden')
        enter(this.backdropTarget);
        enter(this.dialogPanelTarget);
    };
}
