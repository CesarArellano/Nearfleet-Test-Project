"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const addresses_1 = __importDefault(require("../routes/addresses"));
class Server {
    constructor() {
        this.apiPaths = {
            addresses: "/api/addresses",
        };
        this.app = (0, express_1.default)();
        this.port = process.env.PORT || "8000";
        // My routes
        this.routes();
    }
    routes() {
        this.app.use(this.apiPaths.addresses, addresses_1.default);
    }
    listen() {
        this.app.listen(this.port, () => {
            console.log("Server is running on port:", this.port);
        });
    }
}
exports.default = Server;
//# sourceMappingURL=server.js.map