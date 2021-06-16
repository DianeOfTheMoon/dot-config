local gl = require('galaxyline')
local vcs = require('galaxyline.provider_vcs')
local lsp_status = require('lsp-status')
local diagnostics = require('lsp-status/diagnostics')
local messages = require('lsp-status/messaging')
local fileinfo = require('galaxyline.provider_fileinfo')
local sections = gl.section
local icons = fileinfo.define_file_icon()
local condition = require('galaxyline.condition')

gl.short_line_list = {'NvimTree'}

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

local copy_group = function(group, invert)
    local id = vim.fn.synIDtrans(vim.fn.hlID(group))
    local attrs = {}
    for _, mode in pairs({'cterm', 'gui'}) do
        for opposite, layer in pairs({bg = 'fg', fg = 'bg'}) do
            local output = vim.fn.synIDattr(id, layer, mode)
            local attrKey = mode..layer
            if invert == true then
                attrKey = mode..opposite
            end
            if output == nil or output == '' then
            else
                attrs[attrKey] = output
            end
        end
    end
    return attrs
end

local synth_groups = function(groupTable, invert)
    local attrs = {}
    for _, group in pairs(groupTable) do
        attrs = vim.tbl_extend("force", attrs, copy_group(group, invert))
    end
    return attrs
end
vim.highlight.create('InvertQuestion', synth_groups({'StatusLine', 'Question'}, true))

local start_bar = {
    provider = function() return '' end,
    highlight = 'Question',
    separator = ' ',
    separator_highlight = 'InvertQuestion',
}

local end_bar = {
    provider = function() return ' ' end,
    highlight = 'Question',
}

sections.short_line_left[1] = {
    Starting = start_bar
}
sections.short_line_right[1] = {
    Ending = end_bar
}

-- Build it
sections.left[1] = {
    GitIcon = {
        provider = function() return ' ' end,
        condition = condition.check_git_workspace,
        highlight = {icon_colors['Orange']},
    },
}
sections.left[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = 'StatusLineNC',
        separator = ' ',
        separator_highlight = {icon_colors.Aqua},
    },
}
sections.left[3] = {
    GitAdd = {
        provider = 'DiffModified',
        condition = condition.check_git_workspace,
        highlight = 'StatusLineNC',

    }
}
sections.left[4] = {
    Spacer = start_bar
}
sections.left[5] = {
    FileIcon = {
        provider = 'FileIcon',
        highlight = 'InvertQuestion',
    }
}
sections.left[6] = {
    FileName = {
        provider = 'FileName',
        highlight = 'InvertQuestion'
    }
}
sections.left[7] = {
    Location = {
        provider = function()
            --lsp_status.update_current_function()
            local output = vim.b.lsp_current_function
            if output == nil then
                output = vim.fn['nvim_treesitter#statusline']()
            end
            if output == vim.NIL then
                return 'unknown '
            end
            return output .. ' '
        end,
        highlight = 'InvertQuestion',
    }
}
sections.right[1] = {
    LspStatus = {
        provider = function()
            return lsp_status.status()
        end,
        highlight = 'InvertQuestion'
    }
}
sections.right[2] = {
    RightSpace = end_bar
}
sections.right[3] = {
    LineNums = {
        provider = 'LineColumn',
        highlight = 'StatusLineNC',
        separator = ' ',
    }
}

sections.right[4] = {
    Encoding = {
        provider = function()
            return '['..string.lower(string.gsub(fileinfo.get_file_encode(), "^%s*(.-)%s*$", "%1"))..']'
        end,
        highlight = 'StatusLineNC',
        separator = ' ',
    }
}
