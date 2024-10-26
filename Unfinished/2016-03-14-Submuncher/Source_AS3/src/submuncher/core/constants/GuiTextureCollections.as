package submuncher.core.constants {
    import starling.textures.Texture;

    public class GuiTextureCollections {
        private static var _cache:Object = {};

        public static function get monitorCompletion():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorCompletion')){
                _cache['monitorCompletion'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_COMPLETION)
                ];
            }

            return _cache['monitorCompletion'];
        }
        public static function get monitorCompletionDone():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorCompletionDone')){
                _cache['monitorCompletionDone'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_COMPLETION_DONE)
                ];
            }

            return _cache['monitorCompletionDone'];
        }
        public static function get monitorSecret():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorSecret')){
                _cache['monitorSecret'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_SECRET)
                ];
            }

            return _cache['monitorSecret'];
        }
        public static function get monitorSecretDone():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorSecretDone')){
                _cache['monitorSecretDone'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_SECRET_DONE)
                ];
            }

            return _cache['monitorSecretDone'];
        }
        public static function get monitorPar():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorPar')){
                _cache['monitorPar'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_PAR)
                ];
            }

            return _cache['monitorPar'];
        }
        public static function get monitorParDone():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorParDone')){
                _cache['monitorParDone'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_PAR_DONE)
                ];
            }

            return _cache['monitorParDone'];
        }
        public static function get monitorDocument():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorDocument')){
                _cache['monitorDocument'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_DOCUMENT)
                ];
            }

            return _cache['monitorDocument'];
        }
        public static function get monitorDocumentDone():Vector.<Texture>{
            if (!_cache.hasOwnProperty('monitorDocumentDone')){
                _cache['monitorDocumentDone'] = new <Texture>[
                    Gfx.guiAtlas.getTexture(GuiNames.MONITOR_DOCUMENT_DONE)
                ];
            }

            return _cache['monitorDocumentDone'];
        }
    }
}
