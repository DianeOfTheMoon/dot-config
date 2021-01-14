local gl = require('galaxyline')
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
local sections = gl.section
local icons = fileinfo.define_file_icon()
local colors = vim.fn['palenight#GetColors']()

local icon_colors = {
   Brown        = '#905532',
   Aqua         = '#3AFFDB',
   Blue         = '#689FB6',
   Darkblue     = '#44788E',
   Purple       = '#834F79',
   Red          = '#AE403F',
   Beige        = '#F5C06F',
   Yellow       = '#F09F17',
   Orange       = '#D4843E',
   Darkorange   = '#F16529',
   Pink         = '#CB6F6F',
   Salmon       = '#EE6E73',
   Green        = '#8FAA54',
   Lightgreen   = '#31B53E',
   White        = '#FFFFFF',
   LightBlue    = '#5fd7ff',
}

-- Vista needs the autocommand for stuff to show, so do it
vim.api.nvim_command('autocmd VimEnter * call vista#RunForNearestMethodOrFunction()')

-- Build it
sections.left[1] = {
    GitIcon = {
        provider = function() return ' ' end,
        condition = buffer_not_empty,
        highlight = {icon_colors['Orange']},
    },
}
sections.left[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = function() return vcs.check_git_workspace() end,
        highlight = {colors.comment_grey.gui},
        separator = ' ',
        separator_highlight = {icon_colors.Aqua},
    },
}
sections.left[3] = {
    GitAdd = {
        provider = function() 
            if vcs.diff_modified() == nil then 
                    return '~  ' 
            else 
                    return vcs.diff_modified() .. ' '
            end 
        end,
        condition = function() return vcs.check_git_workspace() end,
        highlight = {colors.comment_grey.gui},
        separator = '',
        separator_highlight = {colors.purple.gui}

    }
}
sections.left[4] = {
    Spacer = {
        provider = function() return '   ' end,
        highlight = {colors.special_grey.gui, colors.purple.gui}
    }
}
sections.left[5] = {
    FileName = {
        provider = 'FileName',
        highlight = {colors.special_grey.gui, colors.purple.gui}
    }
}
sections.left[6] = {
    GitRem = {
        provider = 'VistaPlugin',
        highlight = {colors.special_grey.gui, colors.purple.gui}
    }
}

sections.right[1] = {
    LineNums = {
        provider = 'LineColumn',
        highlight = {colors.special_grey.gui, colors.purple.gui}
    }
}

sections.right[2] = {
    Encoding = {
        provider = 'FileEncode',
        highlight = {colors.comment_grey.gui}
    }
}
