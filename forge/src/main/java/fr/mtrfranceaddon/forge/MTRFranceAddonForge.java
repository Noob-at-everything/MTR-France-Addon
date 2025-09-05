package fr.mtrfranceaddon.forge;

import fr.mtrfranceaddon.mod.common.Constants;
import fr.mtrfranceaddon.mod.common.Init;
import net.minecraftforge.api.distmarker.Dist;
import net.minecraftforge.fml.DistExecutor;
import net.minecraftforge.fml.common.Mod;

@Mod(Constants.MOD_ID)
public class MTRFranceAddonForge {

    public MTRFranceAddonForge() {
        Init.init();
        DistExecutor.unsafeRunWhenOn(Dist.CLIENT, () -> Init::initClient);
    }
}
