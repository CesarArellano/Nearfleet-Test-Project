"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.tryCall = void 0;
const tryCall = (functionToExecute, res) => {
    try {
        functionToExecute();
    }
    catch (error) {
        console.log({ error });
        res.status(500).json({
            msg: "Talk to the system administrator",
        });
    }
};
exports.tryCall = tryCall;
//# sourceMappingURL=utils.js.map